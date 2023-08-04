terraform {
  backend "s3" {
    bucket         = "emirates-eks-terraform-backend-store"
    key            = "tfstate/eks_cloudwatch"
    region         = "me-south-1"
    dynamodb_table = "emirates_infra_builder_state_lock"
  }
}