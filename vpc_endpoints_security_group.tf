resource "aws_security_group" "endpoints" {
  name        = "endpoints_sg"
  description = "SG for VPC endpoints"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.0.0/16"]
  }

  tags = {
    Name = "endpoints_sg"
  }
}