resource "aws_lb" "ghost-alb" {
  name               = "ghost-alb"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}