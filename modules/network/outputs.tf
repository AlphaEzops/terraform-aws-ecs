output "vpc_name" {
  description = "The name of the VPC"
  value = module.vpc.name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.default_vpc_id
}

output "azs" {
  description = "The availability zones for the VPC"
  value = module.vpc.azs
}

output "private_subnets" {
  description = "The private subnets for the VPC"
  value = module.vpc.private_subnets
}

output "public_subnets" {
  description = "The public subnets for the VPC"
  value = module.vpc.public_subnets
}

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