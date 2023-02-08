
resource "aws_iam_policy" "ghost_app_policy" {
  name        = "ghost_app_policy"
  path        = "/"
  description = "Policy for ghost role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:DescribeFileSystems",
          "ssm:GetParameter*",
          "secretsmanager:GetSecretValue",
          "kms:Decrypt",
          "elasticloadbalancing:DescribeLoadBalancers",
          "rds:DescribeDBInstances",

        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}