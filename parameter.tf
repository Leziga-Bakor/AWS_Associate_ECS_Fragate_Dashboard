data "aws_caller_identity" "current" {}

# variable "AccountID" {
#   type        = string
#   description = "Account ID"
#   default     = "${data.aws_caller_identity.current.account_id}"
# }

variable "SourceAccessCIDR" {
  type        = string
  description = "Allowed source IPs x.x.x.x/x"
  default     = "0.0.0.0/0"
}

# variable "DBPassword" {
#   type        = string
#   description = "Database password"
#   default     = "${aws_ssm_parameter.foo.value}"
# }

variable "ecr_name" {
  type        = string
  description = "ECR name"
  default     = "ghost"
}