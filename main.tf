terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "cloudx" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "cloudx"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.cloudx.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.cloudx.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_b"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.cloudx.id
  cidr_block              = "10.10.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_c"
  }
}


resource "aws_internet_gateway" "cloudx-igw" {
  vpc_id = aws_vpc.cloudx.id

  tags = {
    Name = "cloudx.igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.cloudx.id



  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloudx-igw.id
  }

  tags = {
    Name = "public_rt"
  }
}



resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow access to bastion"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    description = "Bastion from My IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["89.134.2.36/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion"
  }
}

resource "aws_security_group" "ec2_pool" {
  name        = "ec2_pool"
  description = "Allow access to ec2 instances"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]

  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.cloudx.cidr_block]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_pool"
  }
}


resource "aws_security_group" "alb" {
  name        = "alb"
  description = "Allow access to alb"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["89.134.2.36/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.ec2_pool.id]
  }

  tags = {
    Name = "alb"
  }
}



resource "aws_security_group" "efs" {
  name        = "efs"
  description = "Define access to efs mount points"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_pool.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.cloudx.cidr_block]
  }

  tags = {
    Name = "efs"
  }
}
