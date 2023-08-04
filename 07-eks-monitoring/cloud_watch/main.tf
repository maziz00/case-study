provider "aws" {
  region = "me-south-1"
}

###############################################################
# Configure SNS for Email notification 
###############################################################
resource "aws_sns_topic" "emirates_sns_topic" {
  name         = "emirates_sns_topic"
  display_name = "emirates SNS Topic"
}

# Enable and configure some SNS subscriptions to receive notifications from the emirates_sns_topic



###############################################################
# AWS Elasticsearch Alert based on cluster status
###############################################################
resource "aws_cloudwatch_metric_alarm" "emirates_aws_es_cluster_status" {
  # define some cloudwatch alarms based on elastic search metrics
} 
 