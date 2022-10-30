provider "aws" {
  region = "eu-central-1"
  #access_key = "<AWS_ACCESS_KEY_ID>"        !NOT RECOMMENDED
  #secret_key = "<AWS_SECRET_ACCESS_KEY>"    !NOT RECOMMENDED
}

# COPPIED FROM TERRAFORM DOC AND EDITED
resource "aws_instance" "my_ubuntu" {
  ami           = "ami-06e54d05255faf8f6"
  instance_type = "t3.micro"

  tags = {
    Name  = "My-Ubuntu-Server"
    Owner = "Karaborg"
  }
}

# SECOND RESOURCE
resource "aws_instance" "my_amazon" {
  ami           = "ami-0528a5175983e7f28"
  instance_type = "t3.micro"

  tags = {
    Name  = "My-Amazon-Server"
    Owner = "Karaborg"
  }
}