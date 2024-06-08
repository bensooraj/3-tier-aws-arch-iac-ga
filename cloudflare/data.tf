data "cloudflare_zone" "cf_zone" {
  name = var.cloudflare_zone_name
}

data "aws_route53_zone" "public_hosted_zone" {
  name = var.r53_zone_name
}
