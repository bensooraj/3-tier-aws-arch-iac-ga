# 9. create A record in a R53 PHZ

Date: 2024-06-03

## Status

Accepted

## Context

We need to route traffic from a domain name to the ALB

## Decision

We will create an `A` (`alias`) record in a `public hosted zone` in `Route 53` to route traffic from a (sub)domain to the `Application Load Balancer`.

## Consequences
