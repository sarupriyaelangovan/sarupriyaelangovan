terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
region = "us-east-2"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "saru_ec2" {
    ami="ami-00a929b66ed6e0de6"
    instance_type = "t2.micro"
    key_name = "sowmi"
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]

    tags = {
        name="Saru"
    }
}

resource "aws_s3_bucket" "bucket" {

    bucket = "my-bucket-sowss-2025"
  
}