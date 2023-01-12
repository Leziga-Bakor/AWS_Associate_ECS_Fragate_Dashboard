resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ghost_role.name
  policy_arn = aws_iam_policy.ghost_app_policy.arn
}
