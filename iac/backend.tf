terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-s3-v1"
    key    = "3-tier-aws-arch-iac-ga/terraform.tfstate"
    region = "us-east-1"
  }
}