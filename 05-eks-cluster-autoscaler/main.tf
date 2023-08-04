provider "aws" {
  region = "me-south-1"
}

#######################################
# Install Cluster Autoscaler
#######################################
resource "helm_release" "cluster-autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler" 
  chart      = "cluster-autoscaler"

  # target the workers node group to adjust the cluster nodes based on the cluster need 
}
