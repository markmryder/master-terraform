output "ec2_ip_address" {
    description = "Get the ip address for ec2 instance"
    value = aws_instance.my_vm.public_ip
}