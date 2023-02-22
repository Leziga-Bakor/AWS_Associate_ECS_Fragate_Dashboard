
# resource "aws_lb_listener_rule" "host_based_routing" {
#   listener_arn = aws_lb_listener.front_end.arn
#   priority     = 99

#   action {
#     type             = "forward"
#     #target_group_arn = aws_lb_target_group.ghost-ec2.arn
#     forward {
#       target_group {
#         arn    = aws_lb_target_group.ghost-ec2.arn
#         weight = 50
#       }

#       target_group {
#         arn    = aws_lb_target_group.ghost-fragate.arn
#         weight = 50
#       }

#       stickiness {
#         enabled  = true
#         duration = 600
#       }

#     }
#   }

#   condition {
#     query_string {
#       key   = "health"
#       value = "check"
#     }

#   }

# }