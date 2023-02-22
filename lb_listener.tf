resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ghost-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"

    forward {
      target_group { 
        arn = aws_lb_target_group.ghost-ec2.arn
        weight = 50
      }

      target_group {
        	arn = aws_lb_target_group.ghost-fragate.arn
          weight = 50
      }
    }
  }


}
