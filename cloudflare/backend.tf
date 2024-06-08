terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-s3-v1"
    key    = "cloudflare-iac-ga/terraform.tfstate"
    region = "us-east-1"
  }
}