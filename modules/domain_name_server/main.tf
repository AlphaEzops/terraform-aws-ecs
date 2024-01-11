#===============================================================================
# AWS ROUTE53 - HOSTZONE
#===============================================================================
data "aws_route53_zone" "this" {
  count = var.existent_hostzone_name != null ? 1 : 0
  name  = var.existent_hostzone_name
}

resource "aws_route53_zone" "this" {
  count = var.existent_hostzone_name != null ? 0 : 1
  name  = var.hostzone_name
  tags = var.common_tags
}
#===============================================================================
# ALL RECORDS
#===============================================================================
resource "aws_route53_record" "this" {
  count = length(var.record_config) > 0 ? length(var.record_config) : 0

  zone_id = var.existent_hostzone_name != null ? data.aws_route53_zone.this[0].zone_id : aws_route53_zone.this[0].zone_id
  name    = var.record_config[keys(var.record_config)[count.index]].name
  type    = var.record_config[keys(var.record_config)[count.index]].type
  ttl     = var.record_config[keys(var.record_config)[count.index]].ttl
  records = var.record_config[keys(var.record_config)[count.index]].records
}
#===============================================================================
# ALB CERTIFICATE VALIDATION RECORD ON ROUTE53
#===============================================================================
data "aws_acm_certificate" "alb_certificate" {
  count = var.existent_acm_domain_name != null ? 1 : 0
  domain   =  var.existent_acm_domain_name
  statuses = ["PENDING_VALIDATION"]
}

resource "aws_acm_certificate" "alb_certificate" {
  domain_name               = var.acm_domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.acm_domain_name}"]
}

resource "aws_route53_record" "generic_certificate_validation" {
  zone_id = var.existent_hostzone_name ? data.aws_route53_zone.this[0].zone_id : aws_route53_zone.this[0].zone_id
  name    = tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_type
  ttl     = tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_ttl
  records = [tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_value]
}

resource "aws_acm_certificate_validation" "alb_certificate" {
  certificate_arn         = aws_acm_certificate.alb_certificate.arn
  validation_record_fqdns = [aws_route53_record.generic_certificate_validation.fqdn]
}