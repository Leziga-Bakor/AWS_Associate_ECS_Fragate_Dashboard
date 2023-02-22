resource "aws_vpc_endpoint" "endpoint_ssm" {
  vpc_id = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.ecs_private_a.id,
    aws_subnet.ecs_private_b.id,
    aws_subnet.ecs_private_c.id,
  ]
  security_group_ids = [aws_security_group.endpoints.id]
}


resource "aws_vpc_endpoint" "endpoint_ssm_messages" {
  vpc_id          = aws_vpc.cloudx.id
  service_name    = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids      = [aws_subnet.ecs_private_a.id, aws_subnet.ecs_private_b.id, aws_subnet.ecs_private_c.id]
  security_group_ids = [aws_security_group.endpoints.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "endpoint_ecr_api" {
  vpc_id          = aws_vpc.cloudx.id
  service_name    = "com.amazonaws.us-east-1.ecr.api"
  vpc_endpoint_type = "Interface"
  subnet_ids      = [aws_subnet.ecs_private_a.id, aws_subnet.ecs_private_b.id, aws_subnet.ecs_private_c.id]
  security_group_ids = [aws_security_group.endpoints.id]
  private_dns_enabled = true
}


resource "aws_vpc_endpoint" "endpoint_ecr_dkr" {
  vpc_id = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.ecs_private_a.id, aws_subnet.ecs_private_b.id, aws_subnet.ecs_private_c.id]
  security_group_ids = [aws_security_group.endpoints.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "endpoint_efs" {
  vpc_id = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.elasticfilesystem"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.ecs_private_a.id, aws_subnet.ecs_private_b.id, aws_subnet.ecs_private_c.id]
  security_group_ids = [aws_security_group.endpoints.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "endpoint_cloudwatch" {
  vpc_id = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.monitoring"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.ecs_private_a.id, aws_subnet.ecs_private_b.id, aws_subnet.ecs_private_c.id]
  security_group_ids = [aws_security_group.endpoints.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "endpoint_cloudwatchlogs" {
  vpc_id = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.ecs_private_a.id, aws_subnet.ecs_private_b.id, aws_subnet.ecs_private_c.id]
  security_group_ids = [aws_security_group.endpoints.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "endpoint_s3" {
  vpc_id = aws_vpc.cloudx.id
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.private_rt.id]
}