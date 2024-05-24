# Elastic IP Address (EIP)
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${local.application}-nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.web_subnets[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "${local.application}-nat-gateway"
  }
}

# Route Table
resource "aws_route_table" "nat_rt" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block     = var.all_ipv4_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "${local.application}-nat-route-table"
  }
}

# Route Table Association: App Subnets
resource "aws_route_table_association" "app_subnets_to_nat_rta" {
  count          = length(aws_subnet.app_subnets)
  subnet_id      = aws_subnet.app_subnets[count.index].id
  route_table_id = aws_route_table.nat_rt.id
}

# Route Table Association: Data Subnets
resource "aws_route_table_association" "data_subnets_to_nat_rta" {
  count          = length(aws_subnet.data_subnets)
  subnet_id      = aws_subnet.data_subnets[count.index].id
  route_table_id = aws_route_table.nat_rt.id
}