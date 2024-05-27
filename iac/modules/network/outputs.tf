output "vpc_id" {
  value = aws_vpc.three_tier_vpc.id
}

output "bastion_host_sg_id" {
  value = aws_security_group.bastion_host_sg.id
}

# subnet IDs
output "web_subnet_ids" {
  value = aws_subnet.web_subnets[*].id
}

output "app_subnet_ids" {
  value = aws_subnet.app_subnets[*].id
}

output "data_subnet_ids" {
  value = aws_subnet.data_subnets[*].id
}
