provider "aws" {
  region = "me-south-1"
}

########################
# Bastion Security Group to enable only ssh connections only from trusted ips to connect to workers machines
########################
resource "aws_security_group" "asg_bastion" {
  name        = "emirates-bastion-sg"
  vpc_id      = "" #to complete
  description = "Security Group For Bastion instance"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["Specify CIDR Blocks / IP addresses from where to SSH the Bastion machine"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

########################
# master Security Group / Allow all egress trafic but only ingress from workers and Bastion to connect securely (443) to API Server
########################
resource "aws_security_group" "asg_masters" {
  name        = "emirates-masters-sg"
  description = "Security Group For EKS Masters"
  vpc_id      = "" #to complete

  # to complete
}


########################
# Workers Security Group / Allow all egress trafic but only ingress from the master and Bastion to connect to workers and pods running on them and allow node to node communication
########################
resource "aws_security_group" "asg_workers" {
  name        = "emirates-workers-sg"
  description = "Security Group For EKS Workers"
  vpc_id      = "" #to complete
  
  # to complete
}
