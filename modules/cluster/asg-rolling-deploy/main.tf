resource "aws_launch_template" "asg" {
  name_prefix            = "terraform-asg-template-"
  image_id               = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = var.user_data

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "instance" {
  name = "$terraform-instance-security-groups"

  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.asg.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.subnet_ids
 
  lifecycle {
    create_before_destroy = true
  }

  target_group_arns = var.target_group_arns
  health_check_type = var.health_check_type
  min_elb_capacity = var.min_size
  min_size = var.min_size
  max_size = var.max_size
  
  #配置下面refresh块让asg刷新配置
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["max_size"]
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-asg"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = {
      for key,value in var.custom_tags:key => upper(value)
      if key != "Name"
    }
    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }
}


resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name = "${var.cluster_name}-scale-out-during-business-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name = "${var.cluster_name}-scale-in_at_night"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 9 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}
