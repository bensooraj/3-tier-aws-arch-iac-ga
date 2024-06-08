terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.34.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      environment = var.environment
      owner       = var.owner
      application = var.application
    }
  }
}

# Configure the Cloudflare Provider
provider "cloudflare" {
  # email = var.cloudflare_email
}
