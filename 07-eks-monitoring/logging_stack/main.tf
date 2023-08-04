provider "aws" {
  region = "me-south-1"
}

########################################################################
# Create Namespace Logging                                             #
########################################################################
resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
    labels = {
      name                   = "logging"
      allow-internet-traffic = "true"
    }
  }
}
 
########################################################################
# Create AWS ElasticSearch Service Cluster                             #
########################################################################
resource "aws_elasticsearch_domain" "elastic_logs_domain" {
  domain_name           = "emirates-es-logging"
  
  # Setup the ES domain config
}

########################################################################
# Install Fluentd in EKS Cluster                                       #
########################################################################
resource "helm_release" "fluentd" {
  name       = "fluentd-logging"
  repository = "https://kiwigrid.github.io"
  chart      = "fluentd-elasticsearch"
  namespace  = "logging"

  # Setup the Fluentd config and send logs to the initiated Elasticsearch installed
}