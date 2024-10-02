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

resource "aws_instance" "test-server" {
  ami = "ami-0ebfd941bbafe70c6"
  instance_type = "t2.micro"
  count = var.istest == true ? 1:0

}

resource "aws_instance" "prod-server" {
  ami = "ami-0ebfd941bbafe70c6"
  instance_type = "t2.micro"
  count = var.istest == false ? 1:0

}

