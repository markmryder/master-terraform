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



# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block 
  tags = {
    "Name" = "Production ${var.main_vpc_name}"  # string interpolation
  }
  enable_dns_support = var.enable_dns
}

# Create a subnet in the VPC
resource "aws_subnet" "web"{
  vpc_id = aws_vpc.main.id
  cidr_block = var.web_subnet  
  availability_zone = var.azs[0]
  tags = {
    "Name" = "Web subnet"
  }
}

# Create an Intenet Gateway (IGW)
resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.main_vpc_name} IGW"
  }
}

# Associate the Internet Gateway to the default Route Table (RT)
resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"  # default route
    gateway_id = aws_internet_gateway.my_web_igw.id
  }
  tags = {
    "Name" = "my-default-rt"
  }
}

resource "aws_default_security_group" "default_sec_group" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = var.web_port
    to_port = var.web_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = var.egress_dsg["from_port"]
    to_port = var.egress_dsg["to_port"]
    protocol = var.egress_dsg["protocol"]
    cidr_blocks = var.egress_dsg["cidr_block"]
  }
  tags = {
    "Name" = "Default Security Group"
  }
}

resource "aws_instance" "server" {
  ami = var.amis[var.aws_region]
  instance_type = var.my_instnace[0]
  #cpu_core_count = var.my_instnace[1]
  associate_public_ip_address = var.my_instnace[2]
  count = 1
  tags = {
    "Name" = "Amazon Linux 2"
  }
}
# resource "aws_instance" "my_vm" {
#   ami = data.aws_ami.latest_amazon_linux2.id
#   instance_type = "t2.micro"
#   subnet_id = aws_subnet.web.id
#   vpc_security_group_ids = [aws_default_security_group.default_sec_group.id]
#   associate_public_ip_address = true
#   key_name = aws_key_pair.test_ssh_key.key_name
#   #user_data = file("entry-script.sh")

#   connection {
#     type = "ssh"
#     host = self.public_ip
#     user = "ec2-user"
#     private_key = file("~/.ssh/test_rsa")

#   }
#   provisioner "file" {
#     source = "./entry-script.sh"
#     destination = "/home/ec2-user/entry-script.sh"
    
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /home/ec2-user/entry-script.sh",
#       "/home/ec2-user/entry-script.sh",
#       "exit"
#     ]
#     on_failure = continue
    
#   }

#   tags = {
#     "Name" = "My EC2 instance"
#   }
# }

# resource "aws_key_pair" "test_ssh_key" {
#   key_name = "testing_ssh_key"
#   public_key = file(var.public_key_location)
  
# }

# data "aws_ami" "latest_amazon_linux2" {
#   owners = ["amazon"]
#   most_recent = true
#   filter{
#     name = "name"
#     values = ["amzn2-ami-kernel-*-x86_64-gp2"]
#   }
#   filter {
#     name = "architecture"
#     values=["x86_64"]
#   }
# }