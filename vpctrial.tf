terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
    region ="ap-south-1"
    access_key="AKIAUQZ767I6IW7KWZQT"
    secret_key="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"
    
} 
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {name= "vpc1"}
}

resource "aws_subnet" "mysubnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    tags = {name= "sub1" }

}
resource "aws_subnet" "mysubnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    tags = {name= "sub2" }

}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {name="igw"}
  
}
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.myvpc.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
}
resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.mysubnet1.id
    route_table_id = aws_route_table.rt.id
  
}
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.mysubnet2.id
    route_table_id = aws_route_table.rt.id
  
}
