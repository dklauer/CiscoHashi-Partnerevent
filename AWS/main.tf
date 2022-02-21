terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region
}
#Create VPC
resource "aws_vpc" "hashicorp_vpc" {
  cidr_block = "172.16.0.0/16"
  enable_dns_hostnames = "true"
}
#Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.hashicorp_vpc.id
}
#Create Routing Table
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.hashicorp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
#Create Subnet
resource "aws_subnet" "instance_subnet" {
  vpc_id = aws_vpc.hashicorp_vpc.id
  cidr_block = "172.16.0.0/24"
}
#Associate Subnet
resource "aws_route_table_association" "route_association" {
  subnet_id      = aws_subnet.instance_subnet.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_instance" "app_server" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  count = 1
  subnet_id = aws_subnet.instance_subnet.id

  tags = {
    Name = var.instance_name
  }
}
