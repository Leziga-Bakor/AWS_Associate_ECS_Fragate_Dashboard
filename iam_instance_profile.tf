resource "aws_iam_instance_profile" "ghost-profile" {
  name = "ghost-profile"
  role = aws_iam_role.ghost_role.name

}