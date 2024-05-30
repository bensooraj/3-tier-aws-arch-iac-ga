# Application Load Balancer (ALB)
resource "aws_lb" "alb" {
  name               = "${local.application}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.web_subnet_ids

  enable_deletion_protection = false

  depends_on = [aws_instance.app_server]

  tags = {
    Name = "${local.application}-alb"
  }
}

# Listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.web_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_app_tg.arn
  }
  tags = {
    Name = "${local.application}-alb-listener"
  }
}

# Target Group
resource "aws_lb_target_group" "alb_app_tg" {
  name     = "${local.application}-alb-app-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  slow_start                    = 0
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "instance" # Register targets by instance ID. This is the default value

  health_check {
    path                = "/"
    port                = var.app_port
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = 5
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  depends_on = [aws_instance.app_server]

  tags = {
    Name = "${local.application}-alb-app-tg"
  }
}

# Target Group Attachment
resource "aws_lb_target_group_attachment" "alb_app_tga" {
  count            = length(aws_instance.app_server)
  target_group_arn = aws_lb_target_group.alb_app_tg.arn
  target_id        = aws_instance.app_server[count.index].id
  port             = var.app_port
}
