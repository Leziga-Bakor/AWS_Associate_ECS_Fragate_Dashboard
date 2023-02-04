# resource "aws_security_group_rule" "new_rule" {
#   type                     = "ingress"
#   from_port                = 2368
#   to_port                  = 2368
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.alb.id
#   security_group_id        = aws_security_group.ec2_pool.id

# }
