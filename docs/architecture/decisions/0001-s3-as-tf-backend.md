# 1. Record architecture decisions

Date: 2024-05-18

## Status

Accepted

## Context

A backend defines where Terraform stores its state data files.

## Decision

We will stores the state (`terraform.tfstate`) as a given key (`3-tier-aws-arch-iac-ga/terraform.tfstate`) in a given bucket (`terraform-remote-backend-s3-v1`) on Amazon S3.

## Consequences

Resources:
- [TF S3 backend](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
