variable "ssh_public_key" {
  description = "The SSH public key to use for SSH access"
  type        = string
}

variable "web_subnet_ids" {
  description = "The subnet IDs for the web tier"
  type        = list(string)
}

variable "app_subnet_ids" {
  description = "The subnet IDs for the application tier"
  type        = list(string)
}

variable "data_subnet_ids" {
  description = "The subnet IDs for the data tier"
  type        = list(string)
}

variable "bastion_host_ami_id" {
  description = "The AMI ID for the bastion host"
  type        = string
}

variable "bastion_host_instance_type" {
  description = "The instance type for the bastion host"
  type        = string
}

variable "bastion_host_sg_id" {
  description = "The security group ID for the bastion host"
  type        = string
}

variable "app_server_ami_id" {
  description = "The AMI ID for the app server"
  type        = string
}

variable "app_server_instance_type" {
  description = "The instance type for the app server"
  type        = string
}

variable "app_sg_id" {
  description = "The security group ID for the app server"
  type        = string
}
