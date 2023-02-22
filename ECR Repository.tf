resource "aws_ecr_repository" "ghostecr" {
  name                 = "ghost"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

# provider "docker" {
#   # version = "2.15.0"
# }


# resource "docker_image" "ghost" {
#   name         = "ghost:4.12"
#   keep_locally = false
# }

# data "docker_registry_image" "ghost" {
#   name = docker_image.ghost.name
# }


# resource "aws_ecr_image" "ghost" {
#   repository_name = aws_ecr_repository.ghostecr.name
#   image_tag       = "latest"
#   image_manifest  = data.docker_registry_image.ghost.manifest
# }