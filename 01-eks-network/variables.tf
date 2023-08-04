variable "aws_region" {
  description = "AWS Region"
  default     = "me-south-1"
}

variable "vpc_name" {
  type = string
  default = "emirates-vpc"
}

variable "vpc_cidr" {
  type = string
  default = "192.168.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "azs" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["me-south-1a", "me-south-1b", "me-south-1c"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["192.168.11.0/24", "192.168.12.0/24", "192.168.13.0/24"]
}
