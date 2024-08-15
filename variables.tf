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