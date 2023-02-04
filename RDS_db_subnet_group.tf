# resource "aws_db_subnet_group" "ghost" {
#   name        = "ghost"
#   subnet_ids  = [aws_subnet.private_db_a.id, aws_subnet.private_db_b.id, aws_subnet.private_db_c.id]
#   description = "ghost database subnet group"

#   tags = {
#     Name = "ghost"
#   }
# }