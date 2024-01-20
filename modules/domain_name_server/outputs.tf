output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = try(aws_acm_certificate.acm_certificate[0].arn, null)
}

output "existent_certificate_arn" {
  description = "The ARN of the existent ACM certificate"
  value       = try(data.aws_acm_certificate.this[0].arn, null)
}
