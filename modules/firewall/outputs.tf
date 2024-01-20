#===============================================================================
# LOAD BALANCER SECURITY GROUP
#===============================================================================
output "load_balancer_sg_id" {
  description = "Load balancer security group ID"
  value       = module.load_balancer_sg.security_group_id
}

output "load_balancer_sg_name" {
  description = "Load balancer security group name"
  value       = module.load_balancer_sg.security_group_name
}

output "load_balancer_sg_arn" {
  description = "Load balancer security group ARN"
  value       = module.load_balancer_sg.security_group_arn
}
#===============================================================================
# BASTION SECURITY GROUP
#===============================================================================
output "bastion_sg_id" {
  description = "Bastion security group ID"
  value       = module.bastion_sg.security_group_id
}

output "bastion_sg_name" {
  description = "Bastion security group name"
  value       = module.bastion_sg.security_group_name
}

output "bastion_sg_arn" {
  description = "Bastion security group ARN"
  value       = module.bastion_sg.security_group_arn
}
#===============================================================================
# ECS SECURITY GROUP
#===============================================================================
output "ecs_sg_id" {
  description = "ECS security group ID"
  value       = module.ecs_sg.security_group_id
}

output "ecs_sg_name" {
  description = "ECS security group name"
  value       = module.ecs_sg.security_group_name
}

output "ecs_sg_arn" {
  description = "ECS security group ARN"
  value       = module.ecs_sg.security_group_arn
}
