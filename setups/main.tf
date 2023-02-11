terraform {
  required_providers {
	aws = {
		source = "hashicorp/aws"
		version = "~> 4.0"
    }
  }	
}

provider "aws" {
    region = "us-east-1"
}

provider "aws" {
    alias = "west"
    region = "us-west-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

module "Jat_webserver" {
    source          = "../modules/webserver"
    vpc_id          = aws_vpc.main.id
    cidr_block      = "10.0.0.0/16"
    webserver_name  = "Jatty"
    ami             = "ami-011899242bb902164"
}





// to have another web server (NOT A GOOD PRACTICE, FOR LEARNING)
# module "Jat_webserver_east" {
#     source          = "../modules/webserver"
#     providers       = {
#         aws = aws.west
#     } 
#     vpc_id          = aws_vpc.main.id
#     cidr_block      = "10.0.0.0/16"
#     webserver_name  = "Jatty"
#     ami             = "ami-011899242bb902164"
# }

# output "instance_data" {
#     value = module.Jat_webserver.instance
# }

# resource "aws_elb" "main" {
#     instances = module.Jat_webserver.instance.id
# }

