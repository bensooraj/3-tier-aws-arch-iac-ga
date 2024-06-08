variable "environment" {
  description = "The environment for the project"
  type        = string
}

variable "owner" {
  description = "The owner of the project"
  type        = string
}

variable "application" {
  description = "The application name"
  type        = string
}

# DNS Module
variable "r53_zone_name" {
  description = "The name of the zone to create for the three tier application"
  type        = string
}

variable "cloudflare_account_id" {
  description = "The account ID for the Cloudflare account"
  type        = string
}

variable "cloudflare_email" {
  description = "The email address for the Cloudflare account"
  type        = string
}

variable "cloudflare_zone_name" {
  description = "The name of the zone to create for the three tier application"
  type        = string
}

variable "cloudflare_subdomain" {
  description = "The subdomain to create for the three tier application"
  type        = string
}