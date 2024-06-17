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

variable "ssh_from_bastion_sg_id" {
  description = "The security group ID for allowing SSH from the bastion host"
  type        = string
}

variable "alb_sg_id" {
  description = "The security group ID for the application load balancer"
  type        = string
}

variable "web_port" {
  description = "The port to allow HTTP traffic on"
  type        = number
}

variable "app_port" {
  description = "The port to allow HTTPS traffic on"
  type        = number
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "asg_min_size" {
  description = "The minimum number of instances in the auto scaling group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "The desired number of instances in the auto scaling group"
  type        = number
}

variable "asg_max_size" {
  description = "The maximum number of instances in the auto scaling group"
  type        = number
}
