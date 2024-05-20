output "vpc_id" {
  value = aws_vpc.three_tier_vpc.id
}

output "web_subnet_ids" {
  value = aws_subnet.web_subnets[*].id
}
