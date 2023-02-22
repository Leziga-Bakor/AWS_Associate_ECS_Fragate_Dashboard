resource "aws_lb_target_group" "ghost-ec2" {
  name = "ghost-ec2"
  #target_type = "alb"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = aws_vpc.cloudx.id
}

resource "aws_lb_target_group" "ghost-fragate" {
  name = "ghost-fragate"
  target_type = "ip"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = aws_vpc.cloudx.id
}