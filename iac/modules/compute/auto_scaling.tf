# Launch Template
resource "aws_launch_template" "launch_template" {
  name_prefix   = "${local.application}-"
  image_id      = var.app_server_ami_id
  instance_type = var.app_server_instance_type
  key_name      = aws_key_pair.keypair.key_name
  user_data     = filebase64("scripts/install_httpd.sh")

  vpc_security_group_ids = [
    var.app_sg_id,
    var.ssh_from_bastion_sg_id
  ]

  #   monitoring {
  #     enabled = true
  #   }

  tags = {
    Name        = "${local.application}-launch-template"
    Application = local.application
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  min_size         = var.asg_min_size
  desired_capacity = var.asg_desired_capacity
  max_size         = var.asg_max_size

  # Launch Template
  #   launch_template {
  #     id      = aws_launch_template.launch_template.id
  #     version = "$Latest"
  #   }

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.launch_template.id
      }

      override {
        instance_type = "t2.small"
      }

    }
  }

  vpc_zone_identifier       = var.app_subnet_ids
  target_group_arns         = [aws_lb_target_group.alb_app_tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300


  #   policy to decide how the instances in the Auto Scaling Group should be terminated
  termination_policies = ["OldestInstance"]

  tag {
    key                 = "Name"
    value               = "${local.application}-asg"
    propagate_at_launch = true
  }
}