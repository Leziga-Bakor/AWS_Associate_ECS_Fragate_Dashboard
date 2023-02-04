# resource "aws_subnet" "private_db_a" {
#   vpc_id            = aws_vpc.cloudx.id
#   cidr_block        = "10.10.20.0/24"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "private_db_a"
#   }
# }

# resource "aws_subnet" "private_db_b" {
#   vpc_id            = aws_vpc.cloudx.id
#   cidr_block        = "10.10.21.0/24"
#   availability_zone = "us-east-1b"

#   tags = {
#     Name = "private_db_b"
#   }
# }

# resource "aws_subnet" "private_db_c" {
#   vpc_id            = aws_vpc.cloudx.id
#   cidr_block        = "10.10.22.0/24"
#   availability_zone = "us-east-1c"


#   tags = {
#     Name = "private_db_c"
#   }
# }