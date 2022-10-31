# Build WebServer during Bootstrap with External Template File
provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "web" {
  ami = "ami-0c9bfc21ac5bf10eb" # Amazon Linux 2
  instance_type = "t3.micro"
  #user_data = "yum install httpd -y"
  vpc_security_group_ids = [ aws_security_group.web.id ]
  user_data = templatefile("user_data.sh", {
    f_name = "Kara"
    l_name = "Borg"
    names = [ "One", "Two", "Three", "Four", "Five" ]
  })

  tags = {
    Name = "WebServer Build by Terraform"
    Owner = "Karaborg"
  }
}

resource "aws_security_group" "web" {
  name = "WebServer-SG"
  description = "Security Group for my WebServer" #OPTIONAL

  ingress {
    description = "Allow port HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "Allow port HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress = {
    description = "Allaw ALL Ports"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "WebServer SG by Terraform"
    Owner = "Karaborg"
  }
}