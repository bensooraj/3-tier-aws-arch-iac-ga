terraform {
  backend "s3" {
    key = "base_stack/terraform.tfstate"
  }
}
