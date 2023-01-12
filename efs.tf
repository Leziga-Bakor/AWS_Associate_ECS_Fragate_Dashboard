resource "aws_efs_file_system" "ghost_content" {
  creation_token = "my-product"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name = "ghost_content"
  }
}