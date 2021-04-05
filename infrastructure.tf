module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.47.0"

  name                 = "k8s-${var.cluster_name}-vpc"
  cidr                 = "172.16.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  public_subnets       = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "12.2.0"

   cluster_name    = "eks-${var.cluster_name}"
  cluster_version = "1.18"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  node_groups = {
    first = {
      desired_capacity = var.num_workers
      max_capacity     = var.max_workers
      min_capacity     = var.num_workers

      instance_type = var.instance_type 
    }
  }

  write_kubeconfig   = false
  config_output_path = "./"

  workers_additional_policies = [aws_iam_policy.worker_policy.arn]
}

resource "aws_iam_policy" "worker_policy" {
  name        = "worker-policy-${var.cluster_name}"
  description = "Worker policy for the ALB Ingress"

  policy = file("iam-policy.json")
}


resource "tls_private_key" "alb_key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "alb_cert" {
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.alb_key.private_key_pem
  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  dns_names = ["*.${var.region}.elb.amazonaws.com"]

  subject {
    common_name  = "*.${var.region}.elb.amazonaws.com"
    organization = "ORAG"
    province     = "STATE"
    country      = "COUNT"
  }
}

resource "aws_acm_certificate" "alb_cert" {
  private_key      = tls_private_key.alb_key.private_key_pem
  certificate_body = tls_self_signed_cert.alb_cert.cert_pem
}

resource "helm_release" "aws-lb-controller" {
  name       = "aws-load-balancer-controller"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  version    = "1.1.6"
  wait       = true
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
}