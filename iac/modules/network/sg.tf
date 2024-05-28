# Security Groups for AWS resources

# Bastion Host Security Group (subnet: web)
resource "aws_security_group" "bastion_host_sg" {
  name        = "${local.application}-bastion-sg"
  description = "Allow inbound SSH traffic from the internet"
  vpc_id      = aws_vpc.three_tier_vpc.id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.my_ipv4_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  tags = {
    Name = "${local.application}-bastion-sg"
  }
}

# Generic SSH Security Group
resource "aws_security_group" "ssh_from_bastion_sg" {
  name        = "${local.application}-ssh-from-bastion-sg"
  description = "Allow inbound SSH traffic from the bastion host"
  vpc_id      = aws_vpc.three_tier_vpc.id

  ingress {
    from_port       = var.ssh_port
    to_port         = var.ssh_port
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
    description     = "Allow inbound SSH traffic from the bastion host"
  }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = [var.all_ipv4_cidr]
  # }

  tags = {
    Name = "${local.application}-ssh-from-bastion-sg"
  }
}

# Application Load Balancer Security Group (subnet: web)
resource "aws_security_group" "alb_sg" {
  name        = "${local.application}-alb-sg"
  description = "Allow inbound HTTP and HTTPS traffic from the internet"
  vpc_id      = aws_vpc.three_tier_vpc.id

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
    description = "Allow inbound HTTP traffic from the internet"
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
    description = "Allow inbound HTTPS traffic from the internet"
  }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = [var.all_ipv4_cidr]
  # }
  egress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  tags = {
    Name = "${local.application}-alb-sg"
  }
}

# App Security Group (subnet: app)
resource "aws_security_group" "app_sg" {
  name        = "${local.application}-app-sg"
  description = "Allow inbound TCP traffic from the ALB"
  vpc_id      = aws_vpc.three_tier_vpc.id

  ingress {
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
    description     = "Allow inbound TCP traffic from the ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ipv4_cidr]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${local.application}-app-sg"
  }
}

# Database Security Group (subnet: data)
resource "aws_security_group" "db_sg" {
  name        = "${local.application}-db-sg"
  description = "Allow inbound TCP traffic from the app servers"
  vpc_id      = aws_vpc.three_tier_vpc.id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
    description     = "Allow inbound TCP traffic from the app servers"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ipv4_cidr]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${local.application}-db-sg"
  }
}
