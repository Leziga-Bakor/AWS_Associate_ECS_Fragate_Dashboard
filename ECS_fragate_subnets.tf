resource "aws_subnet" "ecs_private_a" {
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "ecs_private_a"
  }
}

resource "aws_subnet" "ecs_private_b" {
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.11.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "ecs_private_b"
  }
}

resource "aws_subnet" "ecs_private_c" {
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.12.0/24"
  availability_zone = "us-east-1c"


  tags = {
    Name = "ecs_private_c"
  }
}