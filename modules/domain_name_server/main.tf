#===============================================================================
# AWS ROUTE53
#===============================================================================
data "aws_route53_zone" "this" {
    count = var.hostzone_exists ? 1 : 0
    
    name = var.zone_name
    zone_id = var.zone_id
}

resource "aws_route53_zone" "this" {
    count = var.hostzone_exists ? 0 : 1
    name = var.zone_name
}

resource "aws_route53_record" "this" {
    count = length(var.record_config)

    zone_id = var.hostzone_exists ? data.aws_route53_zone.this[0].zone_id : aws_route53_zone.this[0].zone_id
    name    = try(var.record_config[count.index].name, "wwww") 
    type    = try(var.record_config[count.index].type, "CNAME")
    ttl     = try(var.record_config[count.index].ttl, 300)
    records = try(var.record_config[count.index].records, ["www.example.com"])
}

#===============================================================================
# AWS CERTIFICATE MANAGER - 
#===============================================================================
# ERROR - CICLE DEPENDENCY
resource "aws_acm_certificate" "alb_certificate" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.domain_name}"]
}


resource "aws_route53_record" "generic_certificate_validation" {
  name    = tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_type
  zone_id = aws_route53_zone.this.id
  records = [tolist(aws_acm_certificate.alb_certificate.domain_validation_options)[0].resource_record_value]
  ttl     = 300
}


resource "aws_acm_certificate_validation" "alb_certificate" {
  certificate_arn         = aws_acm_certificate.alb_certificate.arn
  validation_record_fqdns = [aws_route53_record.generic_certificate_validation.fqdn]
}