provider "aws" {
  region = "me-south-1"
}

########################################################################
# Create Namespace Monitoring                                          #
########################################################################
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    labels = {
      name                   = "monitoring"
      allow-internet-traffic = "true"
    }
  }
}

########################################################################
# Install Prometheus Operator                                          #
########################################################################
resource "helm_release" "prometheus-operator" {
  name       = "prometheus-operator"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"

  # Setup prometeus config 
}




########################################################################
# Add Automatic backup for Prometheus/grafana with velero              #
########################################################################
resource "null_resource" "backup-with-velero" {
  triggers = {
    manifest_sha1 = filesha1("files/schedule-backup.yml")
  }


  provisioner "local-exec" {
    command = "kubectl apply -f files/schedule-backup.yml"
  }

  depends_on = [
    helm_release.prometheus-operator
  ]
}
