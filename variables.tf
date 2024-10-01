variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "CIDR block for VPC"
  type = string
}
variable "web_subnet" {
  default = "10.0.10.0/24"
  description = "Web Subnet"
  type = string
}

variable "subnet_zone" {
  default = "us-east-1"
}

variable "main_vpc_name" {
    default = "Main VPC"
    type = string
  
}

variable "my_public_ip" {
  
}

variable "aws_secret_key" {

}
variable "aws_access_key" {

}
variable "public_key_location"{

}

variable "web_port" {
  description = "Web port"
  default = 80
  type = number
}

variable "aws_region" {
  type = string
  description = "AWS region"
  default = "us-east-1" 
}
variable "enable_dns" {
  description = "DNS support for the VPC"
  type = bool
  default = true
}
variable "azs" {
  description = "Availability zones in the Region"
  default = ["us-east-1a","us-east-2a"]
  type = list(string)
}
variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0ebfd941bbafe70c6",
    "us-east-2" = "ami-037774efca2da0726"
  }
}
variable "my_instnace"{
  type = tuple([string,number,bool])
  default = [
    "t2.micro",
    1,
    true
  ]
}
variable "egress_dsg"{
  type = object({
    from_port = number
    to_port = number
    protocol = string
    cidr_block = list(string)
  })
  default = {
    from_port = 0
    to_port = 65365
    protocol = "tcp"
    cidr_block = [ "100.0.0.0/16","200.0.0.0/16" ]
  }
}