# 4. Use NAT Gateway to route internet bound traffic from private subnets

Date: 2024-05-24

## Status

Accepted

## Context

A NAT gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that instances in a private subnet can connect to services outside your VPC but external services cannot initiate a connection with those instances

## Decision

We will use one NAT Gateway in one of the public/`web` subnets (most likely in the `us-east-1a` public/`web` subnet). We will route all traffic bound for `0.0.0.0/0` from the `app` and `data` subnets, to the NAT Gateway, as shown below,
```hcl
resource "aws_route_table" "nat_rt" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block     = var.all_ipv4_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}
```

## Consequences
1. We must allocate an Elastic IP address per NAT Gateway.
2. Using only one NAT Gateway can incur cross AZ data transfer charges, which is expensive.

References:
1. [NAT gateways](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html#nat-gateway-api-cli)
