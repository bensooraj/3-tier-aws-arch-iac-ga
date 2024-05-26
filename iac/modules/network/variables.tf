variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
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
  default     = 22
}

variable "http_port" {
  description = "The port to allow HTTP traffic on"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "The port to allow HTTPS traffic on"
  type        = number
  default     = 443
}

variable "web_port" {
  description = "The port to allow web traffic on"
  type        = number
  default     = 8080
}

variable "app_port" {
  description = "The port to allow app traffic on"
  type        = number
  default     = 8081
}

variable "db_port" {
  description = "The port to allow MySQL traffic on"
  type        = number
  default     = 3306
}
