
resource "aws_iam_policy" "ghost_ecr_policy" {
  name        = "ghost_ecr_policy"
  path        = "/"
  description = "Policy for ghost ECR role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
         "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "logs:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}