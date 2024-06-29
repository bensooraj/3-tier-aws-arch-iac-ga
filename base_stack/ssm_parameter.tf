resource "aws_ssm_parameter" "kms_key_id" {
  type  = "String"
  name  = "/${local.environment}/${local.stack_name}/kms_key_id"
  description = "KMS key ID for base stack"
  value = aws_kms_key.base_stack.key_id
  tags = var.default_tags
}