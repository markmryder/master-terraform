terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# resource "aws_instance" "server" {
#   ami = "ami-0ebfd941bbafe70c6"
#   instance_type = "t2.micro"
#   count = 3
# }