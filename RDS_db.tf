resource "aws_db_instance" "ghost" {
  allocated_storage      = 20
  db_name                = "ghost"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  storage_type           = "gp2"
  vpc_security_group_ids = [aws_security_group.mysql.id]
  db_subnet_group_name   = aws_db_subnet_group.ghost.name
  username               = "foo"
  password               = "foobarbaz"
  #   parameter_group_name = "default.mysql5.7"
  #   skip_final_snapshot  = true
}