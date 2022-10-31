# Build WebServer during Bootstrap
provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "web" {
  ami = "ami-0c9bfc21ac5bf10eb" # Amazon Linux 2
  instance_type = "t3.micro"
  #user_data = "yum install httpd -y"
  vpc_security_group_ids = [ aws_security_group.web.id ]
  user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with PrivateIP: $MYIP</h2><br>Build by Terraform" > /var/wwww/html/index.html
service httpd start
chkconfig httpd on
EOF
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