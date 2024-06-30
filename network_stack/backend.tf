terraform {
  backend "s3" {
    key = "network_stack/terraform.tfstate"
  }
}
