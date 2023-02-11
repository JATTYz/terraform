terraform {

backend "s3" {
	  bucket = "devops-testing-tf-state"
      key = "webapp/terraform.tfstate"
      region = "us-east-1"
      dynamodb_table = "terraform-state-locking"
      encrypt = true
	}

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

resource "aws_instance" "instance_1" { 
	ami = "ami-011899242bb902164" # Ubuntu 20.04 LTS // us-east-1
    instance_type = "t2.micro"
    security_groups = [aws_security_group.instances.name]

}
	
resource "aws_instance" "example" {
	ami = "ami-011899242bb902164" # Ubuntu 20.04 LTS // us-east-1
    instance_type = "t2.micro"
}

data "aws_vpc" "default_vpc" {
    default_vpc = true
}


