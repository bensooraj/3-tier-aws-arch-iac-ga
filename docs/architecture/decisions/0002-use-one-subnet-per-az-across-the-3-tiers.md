# 2. Use one subnet per az across the 3 tiers

Date: 2024-05-21

## Status

Accepted

## Context

A subnet is a range of IP addresses in your VPC. You can create AWS resources, such as EC2 instances, in specific subnets. Each subnet must reside entirely within one Availability Zone and cannot span zones. By launching AWS resources in separate Availability Zones, you can protect your applications from the failure of a single Availability Zone.

## Decision

We will split the network into 3 tiers and across 3 availability zones, resulting in the following 9 subnets:

1. Public Layer: 3 public subnets, one on each Availability Zone
2. Application Layer: 3 private subnets, one on each Availability Zone
3. Database Layer: 3 private subnets, one on each Availability Zone

## Consequences
1. Refer: [Subnets for your VPC](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html)