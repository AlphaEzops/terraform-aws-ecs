#===============================================================================
# AWS ROUTE53 - HOSTZONE
#===============================================================================
data "aws_route53_zone" "this" {
  count = var.hostzone_exists ? 1 : 0
  name    = var.domain_name
}

resource "aws_route53_zone" "this" {
  count = var.hostzone_exists ? 0 : 1
  name  = var.domain_name

  tags = var.common_tags
}
#===============================================================================
# ALL RECORDS
#===============================================================================
resource "aws_route53_record" "this" {
  count = length(var.record_config) > 0 ? length(var.record_config) : 0

  zone_id = var.hostzone_exists ? data.aws_route53_zone.this[0].zone_id : aws_route53_zone.this[0].zone_id

  name    = try(var.record_config[keys(var.record_config)[count.index]].name, "www")
  type    = try(var.record_config[keys(var.record_config)[count.index]].type, "CNAME")
  ttl     = try(var.record_config[keys(var.record_config)[count.index]].ttl, 300)
  records = try(var.record_config[keys(var.record_config)[count.index]].records, ["www.example.com"])
}
#===============================================================================
# ALB CERTIFICATE VALIDATION RECORD ON ROUTE53
#===============================================================================
resource "aws_acm_certificate" "alb_certificate" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.domain_name}"]
}

resource "aws_route53_record" "generic_certificate_validation" {
  zone_id = var.hostzone_exists ? data.aws_route53_zone.this[0].zone_id : aws_route53_zone.this[0].zone_id
  name    = tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_type
  ttl     = tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_ttl
  records = [tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_value]
  
}

resource "aws_acm_certificate_validation" "alb_certificate" {
  certificate_arn         = aws_acm_certificate.alb_certificate.arn
  validation_record_fqdns = [aws_route53_record.generic_certificate_validation.fqdn]
}