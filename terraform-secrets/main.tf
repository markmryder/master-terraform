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

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  #db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
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