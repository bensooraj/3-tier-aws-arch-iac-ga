locals {
  application = data.aws_default_tags.provider.tags.application
}

resource "aws_route53_zone" "public_zone" {
  name = var.dns_zone_name
  tags = {
    Name = "${local.application}-public-zone"
  }
}

# A record for ALB
resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.public_zone.zone_id
  name    = var.dns_zone_name
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
