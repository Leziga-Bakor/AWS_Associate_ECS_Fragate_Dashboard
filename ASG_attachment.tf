# resource "aws_autoscaling_attachment" "asg_attachment_bar" {
#   autoscaling_group_name = aws_autoscaling_group.ghost_ec2_pool.id
#   lb_target_group_arn    = aws_lb_target_group.ghost-ec2.arn
# }