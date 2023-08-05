resource "aws_autoscaling_schedule" "ecs_stop" {
  count                  = var.enable_schedule ? 1 : 0
  scheduled_action_name  = "ecs-${var.name}-stop"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  autoscaling_group_name = aws_autoscaling_group.ecs.name
  recurrence             = var.schedule_cron_stop
}

resource "aws_autoscaling_schedule" "ecs_start" {
  count                  = var.enable_schedule ? 1 : 0
  scheduled_action_name  = "ecs-${var.name}-start"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  autoscaling_group_name = aws_autoscaling_group.ecs.name
  recurrence             = var.schedule_cron_start
}