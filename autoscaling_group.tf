resource "aws_autoscaling_group" "ghost_ec2_pool" {
  name                = "ghost_ec2_pool"
  vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  instance_refresh {
    strategy = "Rolling"
  }
  
  launch_template {
    id      = aws_launch_template.ghost.id
    version = "$Latest"
  }

  depends_on = [aws_db_instance.ghost,aws_ecs_service.ghost_service]
  
}