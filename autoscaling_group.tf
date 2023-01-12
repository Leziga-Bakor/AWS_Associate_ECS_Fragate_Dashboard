resource "aws_autoscaling_group" "ghost_ec2_pool" {
  name                = "ghost_ec2_pool"
  vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
  desired_capacity    = 3
  max_size            = 3
  min_size            = 3

  launch_template {
    id      = aws_launch_template.ghost.id
    version = "$Latest"
  }
}