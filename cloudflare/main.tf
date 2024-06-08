# Add NS records to the domain

locals {
  route53_name_servers = data.aws_route53_zone.public_hosted_zone.name_servers
}

resource "cloudflare_record" "ns" {
  count   = length(local.route53_name_servers)
  zone_id = data.cloudflare_zone.cf_zone.id
  name    = var.cloudflare_subdomain
  type    = "NS"
  value   = local.route53_name_servers[count.index]
  ttl     = 1
  comment = "Managed by Terraform - ${var.environment} - ${var.owner} - ${var.application}"
}
