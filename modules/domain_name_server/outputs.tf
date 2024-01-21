output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = try(aws_acm_certificate.acm_certificate[0].arn, null)
}

output "existent_certificate_arn" {
  description = "The ARN of the existent ACM certificate"
  value       = try(data.aws_acm_certificate.this[0].arn, null)
}

output "existent_hostzone_name" {
  description = "The name of the existent hostzone"
  value       = try(data.aws_route53_zone.this[0].name, null)
}

output "hostzone_name" {
  description = "The name of the hostzone"
  value       = try(aws_route53_zone.this[0].name, null)
}

output "existent_hostzone_id" {
  description = "The ID of the existent hostzone"
  value       = try(data.aws_route53_zone.this[0].zone_id, null)
}

output "hostzone_id" {
  description = "The ID of the hostzone"
  value       = try(aws_route53_zone.this[0].zone_id, null)
}
