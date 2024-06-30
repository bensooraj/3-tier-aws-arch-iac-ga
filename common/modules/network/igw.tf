# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.three_tier_vpc.id
  tags = {
    Name = "${local.application}-igw"
  }
}

# Route Table
resource "aws_route_table" "igw_rt" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block = var.all_ipv4_cidr # All traffic / public 
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.application}-igw-rt"
  }
}

# Route Table Association: Web Subnets
resource "aws_route_table_association" "web_subnets_to_igw_rta" {
  count          = length(aws_subnet.web_subnets)
  subnet_id      = aws_subnet.web_subnets[count.index].id
  route_table_id = aws_route_table.igw_rt.id
}
