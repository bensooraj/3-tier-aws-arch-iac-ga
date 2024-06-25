# 11. use launch template and ASG to configure autoscaling

Date: 2024-06-17

## Status

Accepted

## Context

AWS Auto Scaling groups (ASGs) let you easily scale and manage a collection of EC2 instances that run the same instance configuration. Since ASGs are dynamic, Terraform does not manage the underlying instances directly because every scaling action would introduce state drift. 

You can use Terraform lifecycle arguments to avoid drift or accidental changes.

## Decision

We will use the following,
1. Auto Scaling Group
2. Autoscaling policies:
    a. Scale up
    b. Scale down
3. Cloudwatch metrics alarms
    a. Scale up metric alarm
    b. Scale down metric alarm 

We will configure,
2a and 3a to destroy **a** member of the ASG if the EC2 instances in the group use more than 60% CPU over 2 consecutive evaluation periods of 2 minutes. 
2b and 3b to destroy **a** member of the ASG if the EC2 instances in the group use less than 10% CPU over 2 consecutive evaluation periods of 2 minutes. 

## Consequences
