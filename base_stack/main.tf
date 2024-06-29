# KMS key and alias
resource "aws_kms_key" "base_stack" {
  description             = "KMS key for base stack. This key is used to encrypt bucket objects"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "base_stack" {
  name          = var.kms_alias_name
  target_key_id = aws_kms_key.base_stack.key_id
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = var.terraform_state_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}