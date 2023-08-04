provider "aws" {
  region = "me-south-1"
}

#############################################
# Create CloudWatch Group
#############################################
resource "aws_cloudwatch_log_group" "cloudwatch" {
  name              = "emirates-k8s-cloudwatch"
  retention_in_days = 90
}

#############################################
# Create EKS Cluster
#############################################
resource "aws_eks_cluster" "eks" {
  name                      = "emirates-k8s-cluster"
  version                   = "1.27"

  vpc_config {
    # Should be add from network module
  }
}

#############################################
# Generate kubeconfig files
#############################################
resource "local_file" "kubeconfig" {
  content    = local.kubeconfig
  filename   = pathexpand("~/.kube/config")
  depends_on = [aws_eks_cluster.eks]
}
