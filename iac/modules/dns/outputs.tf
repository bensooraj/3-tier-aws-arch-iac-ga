output "dns_name_servers" {
  value = aws_route53_zone.public_zone.name_servers
}
