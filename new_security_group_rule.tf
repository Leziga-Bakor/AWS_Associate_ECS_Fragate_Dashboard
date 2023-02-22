resource "aws_security_group_rule" "new_rule" {
  type                     = "ingress"
  from_port                = 2368
  to_port                  = 2368
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.ec2_pool.id

}

resource "aws_security_group_rule" "new_rule1" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.fragate_pool.id
  security_group_id        = aws_security_group.efs.id

}

resource "aws_security_group_rule" "new_rule2" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.fragate_pool.id
  security_group_id        = aws_security_group.alb.id

}
