output "application_endpoint" {  
  value = kubernetes_ingress.helloworld.load_balancer_ingress.0.hostname
}

output "k8s_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "k8s_kubeconfig" {
  value = module.eks.kubeconfig
}