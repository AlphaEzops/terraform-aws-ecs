output "existent_certificate_arn" {
  description = "The ARN of the existent ACM certificate"
  value       = data.aws_acm_certificate.this.arn
}

output "existent_hostzone_name" {
  description = "The name of the existent hostzone"
  value       = data.aws_route53_zone.this.name
}

output "extistent_zone_id" {
  description = "zone id"
  value       = data.aws_route53_zone.this.id
}
