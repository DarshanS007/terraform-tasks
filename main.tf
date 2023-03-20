provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

variable "cidr_block" {
  description = "cidr block"
  type = list(object({
    cidr_block = string
    Name = string
  }
  ))
}

variable "environment" {
  description = "Environment"
  
}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_block[0].cidr_block
    tags = {
      "Name" = var.cidr_block[0].Name
      "Environment" = var.environment
    }
  
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.cidr_block[1].cidr_block
    availability_zone = "us-east-1a" 
    tags = {
      "Name" = var.cidr_block[1].Name
      "Environment" = var.environment

    }
  
}
data "aws_vpc" "existing-vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "us-east-1a" 
    tags = {
      "Name" = "dev-subnet-2"
      "Environment" = var.environment
    }
  
}

output "dev-vpc-id" {
  value = aws_vpc.dev-vpc.id 
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id 
} 
