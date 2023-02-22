resource "aws_iam_role_policy_attachment" "attach1" {
  role       = aws_iam_role.ghost_ecs.name
  policy_arn = aws_iam_policy.ghost_ecr_policy.arn
}
