resource "aws_autoscaling_group" "ecs" {
  name  = "ecs-${var.name}"

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.ecs.id
        version            = "$Latest"
      }

      dynamic "override" {
        for_each = var.instance_types
        content {
          instance_type = override.value
        }
      }
    }

    instances_distribution {
      spot_instance_pools                      = 3
      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage
    }
  }

  vpc_zone_identifier = var.public_subnet_ids

  min_size = 1
  max_size = 1

  tag {
    key                 = "Name"
    value               = "ecs-node-${var.name}"
    propagate_at_launch = true
  }

  health_check_grace_period = var.autoscaling_health_check_grace_period
  default_cooldown          = 300
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name  = "${var.name}-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status                    = "DISABLED"
    }
  }
}