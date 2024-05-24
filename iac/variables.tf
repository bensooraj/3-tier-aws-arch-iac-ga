variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

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

variable "all_ipv4_cidr" {
  description = "The CIDR block to denote all IPv4 addresses"
  type        = string
  default     = "0.0.0.0/0"
}