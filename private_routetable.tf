resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.cloudx.id

  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_route_table_association_a" {
  subnet_id      = aws_subnet.private_db_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_route_table_association_b" {
  subnet_id      = aws_subnet.private_db_b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_route_table_association_c" {
  subnet_id      = aws_subnet.private_db_c.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "ecs_route_table_association_a" {
  subnet_id      = aws_subnet.ecs_private_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "ecs_route_table_association_b" {
  subnet_id      = aws_subnet.ecs_private_b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "ecs_route_table_association_c" {
  subnet_id      = aws_subnet.ecs_private_c.id
  route_table_id = aws_route_table.private_rt.id
}