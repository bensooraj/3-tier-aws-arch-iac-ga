variable "dns_zone_name" {
  description = "The name of the zone to create for the three tier application"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB to create a record for"
  type        = string
}

variable "alb_zone_id" {
  description = "The zone ID of the ALB to create a record for"
  type        = string
}
