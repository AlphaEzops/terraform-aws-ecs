output "security_group_id" {
  description = "The security group ID"
  value = module.security_group.security_group_id
}

output "security_group_name" {
  description = "The security group name"
  value = module.security_group.security_group_name
}

output "security_group_arn" {
  description = "The security group ARN"
  value = module.security_group.security_group_arn
}