# Welcome
This is me taking notes on GitHub while learning `Terraform`. I will probably be going to need this document when I forget how it works. If you find something useful, be my guest. I will try to update this whenever I study.

## Introduction
It's like programming language to program infrastructure in the Cloud. But not only infrastructure!

Works with:
- Amazon Web Services
- Google Cloud Platform
- Microsoft Azure
- Digital Ocean
- VMware Cloud
- Alibaba Cloud
- Many other platforms, such as; GitHub NewRelic, Okta
- You can create support for your own platform yourself

About Terraform:
- Syntax of code is **HashiCorp Configuration Language (HCL)**
- Regular text files with extension `.tf` and `.tfvars`
- Use any text editor
- No need to compile code
- Works on: **Windows**, **Linux**, **MacOS**, **OpenBSD**, **Solaris**

Another alternative tolls for infrastructure as a code:
- AWS CloudFormation
- Ansible
- Puppet
- Chef

Example of Terraform code to provision Static IP Address

**Azure:**
```
resource "azurerm_public_ip" "my_static_ip_address" {
    name                        = "ip-for-my-web-page"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.myterraformgroup.name
    allocation_method           = "Dynamic"
}
```

**AWS:**
```
resource "aws_eip" "my_static_ip_address" {
    vpc                         = true
}
```

**GCP:**
```
resource "google_compute_address" "my_static_ip_address" {
    name                        = "ip-for-my-web-page"
}
```

Key advantages using Terraform for infrastructure as code:
- ***Automate*** infrastructure provisioning
- ***Change***, ***Update***, ***Delete***, ***Recreate*** infrastructure
- Create ***cloned*** environments of infrastructure
- ***Validate*** changes before apply to production
- Fast grow of environment
- ***Reuse*** code for similar projects and reduce develop costs
- Enhance ***collaboration*** between DevOps teams

## Setup
Download the ***Terraform*** from [terraform.io](https://developer.hashicorp.com/terraform/downloads)

**For Windows:**
- Download the `.exe` file.
- Create the folder path as `C:\Terraform`
- Copy the `.exe` file to new path
- Open `System Environment Variables`
- Click on `Environment Variables`
- Choose `Path` and click on `Edit`
- Click on `New`
- Paste the path `C:\Terraform`
- To check, open any terminal and enter `terraform --version`

> You might also want to install `Terraform` extension to your IDE.

Before we begin, we need to create a ***IAM*** user and give administrator permissions and generate secret key and access key for our Terraform:
- Login AWS Console (if you have multiple accounts, use `root` account)
- Click on `IAM`, then `Users` under IAM resouces
- Add user
- Give a name and check the box with `Programmatic access`
- Continue with `Permissions`
- Choose `Attach existing policies directly` and check the `AdministratorAccess`
- Continue to tags and you can leave it as it is
- Continue to Review and then create the user
- Save the ***access key ID*** and ***secret access key*** or download the ***.csv*** file
- For ***Windows***, open `PowerShell`
  - Enter the commands below:
    - `$env:AWS_ACCESS_KEY_ID="<accessKeyID>"`
    - `$env:AWS_SECRET_ACCESS_KEY="<secretAccessKey>"`
    - `$env:AWS_DEFAULT_REGION="<region>"`
- For ***Linux***/***MacOS***, open `terminal`
  - Enter the commands below:
    - `export AWS_ACCESS_KEY_ID="<accessKeyID>"`
    - `export AWS_SECRET_ACCESS_KEY="<secretAccessKey>"`
    - `export AWS_DEFAULT_REGION="<region>"`

> The ***EXPORT*** command will be lost once you close the terminal.

> The ***region*** might be `us-west-2` or `eu-central-1` or any other region on AWS, whatever you like.

## Basics
Let's begin with our first example:
- Create a folder named `Lab-1`
- Create our first Terraform file under our folder, named `main.tf`
- The first thing we do is add `provider` and if you installed Terraform extension, it will automaticly put the brackets for you
- We also need `resource`. You can also find what is necessary in the [terraform document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- We need our `ami` and `instance_type`
  - To find ***AMI*** (Amazon Machine Image), go to ***AWS Console***
  - Go to ***EC2*** and then ***Instances*** then ***Launch Instances***
  - You can now see the list of ***AMI*** and can copy the one you would like to use
    - We choosed `Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami-06e54d05255faf8f6`
- We then, give a ***name*** and ***owner*** inside of our `tags`

So, our first example should look like this:
```
provider "aws" {
  region      = "eu-central-1"
  #access_key = "<AWS_ACCESS_KEY_ID>"        !POSSIBLE BUT NOT RECOMMENDED
  #secret_key = "<AWS_SECRET_ACCESS_KEY>"    !POSSIBLE BUT NOT RECOMMENDED
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
```

After that, open a terminal and go to the path where your `.tf` file is located. Then, we need to execute the first Terreform command, which is `terraform init`. Which will read all the `.tf` files under that path and check and download which providers are in use.

> If you are pushing your project on `GitHub`, you might want to create a `.gitignore` file and add the downloaded terraform files there.

Moreover, to start creating resources, we need to type `terraform plan`. Which will check our files and show you what it is going to create but, **it will not create anything yet**.

The next command is `terraform apply`. This will basically show you the exact same thing with the planning but this time, it will ask you if you want to execute. 

If you enter ***yes***, terraform will create the instance based on your file. 

> Using `terraform apply` command twice will not create another instance. Terraform will check your files if it is the same instance.

You can also add another ***resource*** to your `main.tf` file as shown below:
```
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
```

After that, you can type `terraform plan` and then `terraform apply`. And that will create the non-existing instance for you and will not touch the already-existing instance if there are no changes for that.

### Update Resources
You can make any updates/changes on your `.tf` file. To apply those updates/changes, you will need to enter `terraform plan` and then `terraform apply` again. Those 2 commands will always check your file and will tell you if it's going to ***add***, ***update*** or ***delete*** something.

### Destroy Resources
To destroy any resources, you can open the `.tf` file and delete the resource you want, maybe comment it out. Then again, you will need to enter `terraform plan` and then `terraform apply`.

> If you want to destroy ***everything***, you can use the command `terraform destroy`. Which will destroy everything inside of your `.tf` file.

## Provisioning of Web Server

### Bootstrap simple WebServer on AWS
```
# Build WebServer during Bootstrap
provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "web" {                                                                         # our aws instance
  ami = "ami-0c9bfc21ac5bf10eb"                                                                         # Amazon Linux 2
  instance_type = "t3.micro"
  #user_data = "yum install httpd -y"                                                                   # this works too
  vpc_security_group_ids = [ aws_security_group.web.id ]                                                # to make our instance to use our security group
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
  description = "Security Group for my WebServer"                                                       # OPTIONAL

  ingress {                                                                                             # to open incoming port 80
    description = "Allow port HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {                                                                                             # to open incoming port 433
    description = "Allow port HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress = {                                                                                            # to open outgoing ports
    description = "Allaw ALL Ports"
    from_port = 0                                                                                       # means ALL ports
    to_port = 0                                                                                         # means ALL ports
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "WebServer SG by Terraform"
    Owner = "Karaborg"
  }
}
```

After that, you can enter `terraform init`, `terraform plan` and then `terraform apply`. Therefore, Terraform will create the security group and the web server.

### Bootstrap simple WebServer with External Static file for user_data
**Without external file:**
```
resource "aws_instance" "web" {                                                                         # our aws instance
  ami = "ami-0c9bfc21ac5bf10eb"                                                                         # Amazon Linux 2
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.web.id ]                                                # to make our instance to use our security group
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
```

**With external static file:**
```
resource "aws_instance" "web" {
  ami = "ami-0c9bfc21ac5bf10eb" # Amazon Linux 2
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.web.id ]
  user_data = file("user_data.sh")                           # we saved the sh somewhere and gave it's path

  tags = {
    Name = "WebServer Build by Terraform"
    Owner = "Karaborg"
  }
}
```

### Bootstrap simple WebServer with External Template/Dynamic file for user_data

**With external static file:**
```
resource "aws_instance" "web" {
  ami = "ami-0c9bfc21ac5bf10eb" # Amazon Linux 2
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.web.id ]
  user_data = file("user_data.sh")

  tags = {
    Name = "WebServer Build by Terraform"
    Owner = "Karaborg"
  }
}
```

**With external template/dynamic file:**
```
resource "aws_instance" "web" {
  ami = "ami-0c9bfc21ac5bf10eb" # Amazon Linux 2
  instance_type = "t3.micro"
  #user_data = "yum install httpd -y"
  vpc_security_group_ids = [ aws_security_group.web.id ]
  user_data = templatefile("user_data.sh", {                 # to send data
    f_name = "Kara"
    l_name = "Borg"
    names = [ "One", "Two", "Three", "Four", "Five" ]
  })

  tags = {
    Name = "WebServer Build by Terraform"
    Owner = "Karaborg"
  }
}
```

## Working with GCP

## Expansion of Terraform Features

## Features of Last Resort

## Advanced Features

## Super Important Advanced Features

## Less Used But Anyway

## Other Terraform Things To Know For The Exam

## Best Practice And Recommendations

## Exam
