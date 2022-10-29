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

## Basics

## Provisioning of Web Server

## Working with GCP

## Expansion of Terraform Features

## Features of Last Resort

## Advanced Features

## Super Important Advanced Features

## Less Used But Anyway

## Other Terraform Things To Know For The Exam

## Best Practice And Recommendations

## Exam
