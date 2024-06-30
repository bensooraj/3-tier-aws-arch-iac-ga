variable "default_tags" {
  description = "Map of default tags"
  type = object({
    environment = string
    owner       = string
    application = string
    stack_name  = string
  })
}

variable "primary_region" {
  type        = string
  description = "Primary region for the stack"
}

variable "failover_region" {
  type        = string
  description = "Failover region for the stack"
}

variable "create_primary" {
  type        = bool
  description = "Create a primary region for the stack"
}

variable "create_failover" {
  type        = bool
  description = "Create a failover region for the stack"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "all_ipv4_cidr" {
  description = "The CIDR block to denote all IPv4 addresses"
  type        = string
  default     = "0.0.0.0/0"
}
