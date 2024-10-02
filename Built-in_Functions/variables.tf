variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "192.168.0.0/16"
  type        = string
}

variable "web_subnet" {
  description = "Subnet for web apps"
  type        = string
  default     = "192.168.100.0/24"

}

variable "subnet_zone" {
  type    = string
  default = "us-east-1b"
}

variable "main_vpc_name" {
  type    = string
  default = "Main VPC"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami" {
  type = map(string)
  default = {
    "us-west-1"    = "ami-02d03ce209db75523"
    "us-west-2"    = "ami-066333d9c572b0680"
    "eu-central-1" = "ami-05cafdf7c9f772ad2"
    "eu-west-1"    = "ami-01efa4023f0f3a042"
  }
}

variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0ebfd941bbafe70c6",
    "us-east-2" = "ami-037774efca2da0726"
  }
}

variable "aws_region" {
  type = string
  description = "AWS region"
  default = "us-east-1" 
}
variable "aws_secret_key" {

}
variable "aws_access_key" {

}
variable "public_key_location"{

}