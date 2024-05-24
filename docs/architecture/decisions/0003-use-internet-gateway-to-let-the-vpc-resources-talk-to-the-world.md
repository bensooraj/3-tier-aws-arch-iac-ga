# 3. use internet gateway to let the VPC resources talk to the world

Date: 2024-05-22

## Status

Accepted

## Context

An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between our VPC and the internet.

It enables resources in the public subnets (such as EC2 instances) to connect to the internet if the resource has a public IPv4 address or an IPv6 address. Similarly, resources on the internet can initiate a connection to resources in the subnet using the public IPv4 address or IPv6 address. For example, an internet gateway enables you to connect to an EC2 instance in AWS using your local computer.

**Note**: An internet gateway provides a target in your VPC route tables for internet-routable traffic.

## Decision

We will attach an IGW to our VPC. We will route all traffic bound for `0.0.0.0/0` from the `web` subnets, to the Internet Gateway, as shown below,
```hcl
resource "aws_route_table" "igw_rt" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block = var.all_ipv4_cidr # All traffic / public 
    gateway_id = aws_internet_gateway.igw.id
  }
}
```

## Consequences
