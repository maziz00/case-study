provider "aws" {
  region = "me-south-1"
}

######################################################################
# Install Nginx Ingress                                              
######################################################################
resource "kubernetes_namespace" "nginx-ingress-controller" {
  metadata {
    name = "nginx-ingress-controller"
    labels = {
      name                   = "nginx-ingress-controller"
      
    }
  }
}

resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "nginx-ingress-controller"
  
  # Ingress configuration to be completed
}

######################################################################
# Install ALB Ingress                                               
######################################################################
resource "kubernetes_namespace" "alb-ingress-controller" {
  metadata {
    name = "alb-ingress-controller"
    labels = {
      name                   = "alb-ingress-controller"
      allow-internet-traffic = "true"
    }
  }
}

resource "helm_release" "alb-ingress" {
  name       = "alb-ingress"
  repository = "https://charts.helm.sh/incubator"
  chart      = "aws-alb-ingress-controller"
  namespace  = "alb-ingress-controller"

  # configuration to be completed to make the ALB fronting the ingress
}
 