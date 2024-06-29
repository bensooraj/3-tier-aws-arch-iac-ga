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

variable "terraform_state_bucket" {
  type        = string
  description = "Name of the S3 bucket to store Terraform state"
}

variable "terraform_state_key" {
  type        = string
  description = "Name of the S3 key to store Terraform state"
}

variable "kms_alias_name" {
  type        = string
  description = "Name of the KMS alias"
}

variable "terraform_state_lock_table_name" {
  type        = string
  description = "Name of the DynamoDB table to store Terraform state lock"
}