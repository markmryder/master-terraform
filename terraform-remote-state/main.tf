terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Create an EC2 instance
resource "aws_instance" "server" {
  ami = "ami-037774efca2da0726"
  instance_type = "t2.micro"
}



variable "aws_secret_key" {

}
variable "aws_access_key" {

}
variable "aws_region" {
  type = string
  description = "AWS region"
  default = "us-east-2" 
}

# terraform {
#   backend "s3" {
#     bucket = "myfirstterraforms3"  # should already exist on AWS S3
#     key    = "s3_backend.tfstate"
#     #dynamodb_table = "s3-state-lock"  # should already exist on AWS

#     region     = "us-east-2"
#     aws_access_key = #These values must be hardcoded
#     aws_secret_key = #These values must be hardcoded
#   }
# }