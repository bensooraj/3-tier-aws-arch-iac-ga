# 5. use security groups for resource level network security

Date: 2024-05-26

## Status

Accepted

## Context

A security group controls the traffic that is allowed to reach and leave the resources that it is associated with. For example, after you associate a security group with an EC2 instance, it controls the inbound and outbound traffic for the instance.

## Decision

We will use security groups for controlling inbound and outbound traffic to the web, app and database servers.

## Consequences

1. [Control traffic to your AWS resources using security groups](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html#security-group-basics)
