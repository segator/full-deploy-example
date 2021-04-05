resource "helm_release" "backend-service" {
  name       = "backend"
  chart      = "./charts/services/backend"
  wait       = true
  namespace  = "application"
  create_namespace = true

  set {
    name  = "ingress.annotations.alb\\.ingress\\.kubernetes\\.io/certificate-arn"
    value = aws_acm_certificate.alb_cert.arn
    type  = "string"
  }
}

resource "kubernetes_ingress" "helloworld" {
  depends_on = [helm_release.backend-service]
  wait_for_load_balancer = true
  metadata {
    name = "backend"
    namespace = "application"
    annotations = {
       "kubernetes.io/ingress.class" = "alb"
       "alb.ingress.kubernetes.io/scheme"="internet-facing"
       "alb.ingress.kubernetes.io/listen-ports"="[{\"HTTP\": 80}, {\"HTTPS\":443}]"
       "alb.ingress.kubernetes.io/actions.ssl-redirect"="{\"Type\": \"redirect\", \"RedirectConfig\": { \"Protocol\": \"HTTPS\", \"Port\": \"443\", \"StatusCode\": \"HTTP_301\"}}"
       "alb.ingress.kubernetes.io/certificate-arn"=aws_acm_certificate.alb_cert.arn
    }    
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = "ssl-redirect"
            service_port = "use-annotation"
          }
          path = "/*"
        }

        path {
          backend {
            service_name = "backend"
            service_port = "http"
          }

          path = "/*"
        }
      }
    }
  }
}