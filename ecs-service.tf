resource "aws_ecs_service" "default" {
  name            = "${var.name}-service"
  cluster         = var.name
  task_definition = var.task_definition_arn == "" ? aws_ecs_task_definition.default[0].arn : var.task_definition_arn
  desired_count   = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  lifecycle {
    ignore_changes = [task_definition]
  }
}