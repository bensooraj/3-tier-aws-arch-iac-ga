resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${local.application}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.web_subnets[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "${local.application}-nat-gateway"
  }
}

resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block     = var.all_ipv4_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "${local.application}-nat-route-table"
  }
}

resource "aws_route_table_association" "app_subnets_to_nat_rta" {
  count          = length(aws_subnet.app_subnets)
  subnet_id      = aws_subnet.app_subnets[count.index].id
  route_table_id = aws_route_table.nat_route_table.id
}

resource "aws_route_table_association" "data_subnets_to_nat_rta" {
  count          = length(aws_subnet.data_subnets)
  subnet_id      = aws_subnet.data_subnets[count.index].id
  route_table_id = aws_route_table.nat_route_table.id
}