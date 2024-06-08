# 10. configure Route53 nameservers in Cloudflare

Date: 2024-06-08

## Status

Accepted

## Context

The application should be accessible from a public domain (`app.zeronet.work`) registered in an external registrar (`cloudflare`).

## Decision

1. We will create a public hosted zone for `app.zeronet.work` in AWS Route53. A set of nameservers will be assigned to this hosted zone.
2. In the registrar's (`cloudflare`) DNS management portal, create an NS record for each nameserver from the previous step for the domain `app.zeronet.work`.

## Consequences

The application can be accessed from the public domain (`app.zeronet.work`).
