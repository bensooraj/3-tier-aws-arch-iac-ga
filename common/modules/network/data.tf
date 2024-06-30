# Access individual default_tags via the data source
data "aws_default_tags" "provider" {}
data "aws_availability_zones" "available" {
  state = "available"
}
