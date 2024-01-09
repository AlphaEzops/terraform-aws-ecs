output "domain_name_server" {
  description = "The name servers for the domain"
  value       = var.hostzone_exists ? data.aws_route53_zone.this[0].name_servers : aws_route53_zone.this[0].name_servers
}

output "domain_name" {
  description = "The name of the domain"
  value       = var.hostzone_exists ? data.aws_route53_zone.this[0].name : aws_route53_zone.this[0].name
}

output "domain_id" {
  description = "The ID of the domain"
  value       = var.hostzone_exists ? data.aws_route53_zone.this[0].zone_id : aws_route53_zone.this[0].zone_id
}

output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.alb_certificate.arn
}
