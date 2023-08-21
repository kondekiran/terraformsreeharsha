# data "aws_ami" "my_ami" {
#      most_recent      = true
#      #name_regex       = "^mavrick"
#      owners           = ["721834156908"]
# }


resource "aws_instance" "web-1" {
  ami = var.imagename
  #ami = "ami-0d857ff0f5fc4e03b"
  #ami = "${data.aws_ami.my_ami.id}"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name  = "${var.vpc_name}-Server-1"
    Env   = var.environment
    Owner = var.owner
  }
  user_data = <<-EOF
		#!/bin/bash
    sudo apt-get update
		sudo apt-get install -y nginx net-tools jq unzip
		echo "<h1>${var.vpc_name}-Server-1</h1>" | sudo tee -a /var/www/html/index.nginx-debian.html
	EOF
}

# resource "aws_instance" "web-2" {
#   ami = var.imagename
#   #ami = "ami-0d857ff0f5fc4e03b"
#   #ami = "${data.aws_ami.my_ami.id}"
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   subnet_id                   = aws_subnet.subnet1-public.id
#   vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
#   associate_public_ip_address = true
#   tags = {
#     Name  = "Server-2"
#     Env   = var.environment
#     Owner = var.owner
#   }
#   user_data = <<-EOF
# 		#!/bin/bash
#         sudo apt-get update
# 		sudo apt-get install -y nginx net-tools jq unzip
# 		echo "<h1>Deployed via Terraform</h1>" | sudo tee -a /var/www/html/index.nginx-debian.html
# 	EOF
# }