# 7. app server for running the business logic

Date: 2024-05-28

## Status

Accepted

## Context

We need a set of servers for hosting/running the actual application that makes money for the business.

## Decision

We will run these app servers (one each in the 3 `us-east-1` AZs) in the private `app` subnet.

## Consequences

We now know where to run the application that executes the business logic.
