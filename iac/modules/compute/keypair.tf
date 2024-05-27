# SSH Key Pair
resource "aws_key_pair" "keypair" {
  key_name   = "${local.application}-keypair"
  public_key = var.ssh_public_key
}