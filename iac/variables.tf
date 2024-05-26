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

variable "my_ipv4_cidr" {
  description = "The CIDR block for my IPv4 address"
  type        = string
}

variable "ssh_port" {
  description = "The port to allow SSH traffic on"
  type        = number
}

variable "web_port" {
  description = "The port to allow HTTP traffic on"
  type        = number
}

variable "app_port" {
  description = "The port to allow HTTPS traffic on"
  type        = number
}

variable "db_port" {
  description = "The port to allow MySQL traffic on"
  type        = number
}

variable "ssh_public_key" {
  description = "The SSH public key to use for SSH access"
  type        = string
}