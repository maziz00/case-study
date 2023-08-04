provider "aws" {
  region = "me-south-1"
}

#############################################
# VPC
#############################################
resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support

  tags = merge(
    {
      "Name" = var.vpc_name
    }
  )
}

#############################################
# Public subnet
#############################################
resource "aws_subnet" "public" {
  count =  length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = element(concat(var.public_subnets, [""]), count.index)
  availability_zone               = element(var.azs, count.index)

  tags = merge(
    {
      "Name" = format("public-subnet-emirates-%s", element(var.azs, count.index))
    }
  )
}

#############################################
# Private subnet
#############################################
resource "aws_subnet" "private" {
  count =  length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = var.private_subnets[count.index]
  availability_zone               = element(var.azs, count.index)

  tags = merge(
    {
      "Name" = format("private-subnet-emirates-%s", element(var.azs, count.index))
    }
  )
}
