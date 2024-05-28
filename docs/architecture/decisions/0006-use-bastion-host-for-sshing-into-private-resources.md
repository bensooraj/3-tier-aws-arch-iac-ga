# 6. use bastion host for SSHing into private resources

Date: 2024-05-28

## Status

Accepted

## Context

The Engineering team needs to access the app/api/data resources running in private subnets for any ad-hoc troubleshooting.

![arch](./images/0006-NM-diagram-061316-a.png)

## Decision

We will use a Bastion host (`web` subnet) to SSH into resources that reside in the private subnets (`app` and `data`). We will not use Systems Manager for now.

## Consequences

Allows developers to SSH into private resources for debugging and troubleshooting!

References:
1. [Linux Bastion Hosts on AWS](https://aws-ia.github.io/cfn-ps-linux-bastion/)
