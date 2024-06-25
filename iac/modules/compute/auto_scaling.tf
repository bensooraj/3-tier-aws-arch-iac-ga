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
  lifecycle {
    create_before_destroy = true
  }

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
  health_check_type         = "ELB"
  health_check_grace_period = 300


  #   policy to decide how the instances in the Auto Scaling Group should be terminated
  termination_policies = ["OldestInstance"]

  # 
  lifecycle {
    ignore_changes = [target_group_arns, desired_capacity]
  }

  tag {
    key                 = "Name"
    value               = "${local.application}-asg"
    propagate_at_launch = true
  }
}

# While it may make sense to define a desired capacity at launch time, you should rely on scaling policies or other mechanisms to manage the instance count over the ASG's lifecycle. To do so, you must ignore the desired_capacity value for future Terraform operations using a Terraform lifecycle rule. For example, if you manually scale your group to 5 instances to respond to higher traffic load and also modify your user data script, applying the configuration would update your launch configuration with the new user data but also scale down the number of instances to 1, risking overloading the machine.
# Terraform also attempts to overwrite the association of your ASG and target group. You can associate a target group with an ASG both through a standalone resource as done in the current configuration, or through an inline argument to the aws_autoscaling_group resource. The two are mutually exclusive, so if you use the aws_autoscaling_attachment resource as done in this configuration, you must ignore changes to the attribute of the ASG resource itself.
# source: https://developer.hashicorp.com/terraform/tutorials/aws/aws-asg

# This allows AWS to automatically add and remove instances from the target group over their lifecycle.
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = aws_lb_target_group.alb_app_tg.arn
}

# trigger scaling events in response to metric thresholds or other benchmarks.
# Autoscaling Policy
resource "aws_autoscaling_policy" "asg_scale_down" {
  name                   = "${local.application}-asg-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_policy" "asg_scale_up" {
  name                   = "${local.application}-asg-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

# CloudWatch Alarms
# Scale down
# This policy configures your Auto Scaling group to destroy a member of the ASG if the EC2 instances in your group use less than 10% CPU over 2 consecutive evaluation periods of 2 minutes. This type of policy would allow you to optimize costs.
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_description   = "Monitors CPU utilization for ASG"
  alarm_actions       = [aws_autoscaling_policy.asg_scale_down.arn]
  alarm_name          = "${local.application}-scale-down-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "10"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}
# Scale up
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_description   = "Monitors CPU utilization for ASG"
  alarm_actions       = [aws_autoscaling_policy.asg_scale_up.arn]
  alarm_name          = "${local.application}-scale-up-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "60"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}
