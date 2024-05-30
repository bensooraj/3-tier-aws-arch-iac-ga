# 8. use AWS ALB to distribute traffic across the app servers

Date: 2024-05-30

## Status

Accepted

## Context

The application servers are spread across the `app` subnets across. The `app` subnets are spread across the three availibility zones. We need a way to spread incoming HTTP traffic from internet among these `app` servers.

## Decision

We will use an Application Load Balancer to distribute traffic among the `app` servers in a round-robin manner.

For the implementation, we will:
1. Create an Application Load Balancer (`aws_lb`) spread across `web` subnets
1. Attach (`aws_lb_target_group_attachment`) the `app` servers (`aws_instance`) to a Target Group (`aws_lb_target_group`)
2. Create an ALB listener (`aws_lb_listener`) listening on port `80`, configured (`default` rule) to `forward` traffic to the target group.

## Consequences

References:
1. [What is an Application Load Balancer?](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
