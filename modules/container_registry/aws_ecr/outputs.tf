output "aws_ecr_repository_name" {
  value       = [for value in aws_ecr_repository.this : value.name]
  description = "The name of the repository"
}

output "aws_ecr_repository_arn" {
  value       = [for value in aws_ecr_repository.this : value.arn]
  description = "The ARN of the repository"
}

output "aws_ecr_repository_url" {
  value       = [for value in aws_ecr_repository.this : value.repository_url]
  description = "The URL of the repository (in the form `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`)"
}
