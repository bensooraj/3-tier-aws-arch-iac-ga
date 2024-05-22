# 3. use internet gateway to let the VPC resources talk to the world

Date: 2024-05-22

## Status

Accepted

## Context

An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between our VPC and the internet.

It enables resources in the public subnets (such as EC2 instances) to connect to the internet if the resource has a public IPv4 address or an IPv6 address. Similarly, resources on the internet can initiate a connection to resources in the subnet using the public IPv4 address or IPv6 address. For example, an internet gateway enables you to connect to an EC2 instance in AWS using your local computer.

**Note**: An internet gateway provides a target in your VPC route tables for internet-routable traffic.

## Decision

We will attach an IGW to our VPC.

## Consequences

Resources:
1. [Connect to the internet using an internet gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)