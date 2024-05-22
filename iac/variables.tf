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
