# resource "aws_security_group" "mysql" {
#   name        = "myql"
#   description = "defines access to ghost db"
#   vpc_id      = aws_vpc.cloudx.id

#   ingress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [aws_security_group.ec2_pool.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "mysql"
#   }
# }