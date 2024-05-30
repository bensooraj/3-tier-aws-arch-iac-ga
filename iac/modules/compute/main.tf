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
  instance_type = var.bastion_host_instance_type
  key_name      = aws_key_pair.keypair.key_name
  subnet_id     = random_shuffle.random_web_subnet_id.result[0]

  vpc_security_group_ids      = [var.bastion_host_sg_id]
  associate_public_ip_address = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${local.application}-bastion-host"
  }
}

# App Server
resource "aws_instance" "app_server" {
  count         = length(var.app_subnet_ids)
  ami           = var.app_server_ami_id
  instance_type = var.app_server_instance_type
  key_name      = aws_key_pair.keypair.key_name
  subnet_id     = var.app_subnet_ids[count.index]

  vpc_security_group_ids = [
    var.app_sg_id,
    var.ssh_from_bastion_sg_id
  ]

  user_data = file("scripts/install_httpd.sh")

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${local.application}-app-server-${count.index}"
  }
}
