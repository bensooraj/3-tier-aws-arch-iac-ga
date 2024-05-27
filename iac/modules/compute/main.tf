locals {
  application = data.aws_default_tags.provider.tags.application
}

resource "random_shuffle" "random_web_subnet_id" {
  input        = var.web_subnet_ids
  result_count = 1
}

# Bastion Host
resource "aws_instance" "bastion_host" {
  ami           = var.bastion_host_ami_id
  instance_type = var.bastion_host_ami_id
  key_name      = aws_key_pair.keypair.key_name
  subnet_id     = random_shuffle.random_web_subnet_id.result[0]

  vpc_security_group_ids      = [var.bastion_host_sg_id]
  associate_public_ip_address = true

  tags = {
    Name = "${local.application}-bastion-host"
  }
}
