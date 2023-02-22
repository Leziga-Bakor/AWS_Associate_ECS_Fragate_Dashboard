output "LBDNS" {
  description = "DNS Name of the load balancer"
  value = aws_lb.ghost-alb.dns_name
}

output "BastionDNS" {
  description = "DNS Name of Bastion Instance"
  value = aws_instance.bastion.public_dns
}

output "DBDNS" {
  description = "DB DNS Name"
  value = aws_db_instance.ghost.address
}

output "EFSID" {
  description = "EFS Id"
  value = aws_efs_file_system.ghost_content.id
}

output "AccoundID" {
  description = "aws account ID"
  value = data.aws_caller_identity.current.account_id
}

output "DB_endpoint" {
  description = "database endpoint"
  value = replace(aws_db_instance.ghost.endpoint, "/:[0-9]+/", "") #aws_db_instance.ghost.endpoint
}