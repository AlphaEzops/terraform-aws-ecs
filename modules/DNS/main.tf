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