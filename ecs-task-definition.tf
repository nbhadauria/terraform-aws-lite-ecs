resource "aws_ecs_task_definition" "default" {
  count = var.task_definition_arn == "" ? 1 : 0
  family = "${var.name}-td"

  execution_role_arn = aws_iam_role.ecs_task.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  volume {
    name      = "${var.name}"
    host_path = "/mnt/efs/${var.name}"
  }

  container_definitions = <<EOT
[
  {
    "name": "${var.name}",
    "image": "${var.image}",
    "memoryReservation": 256,
    "essential": true,
    "portMappings": [
      {
        "hostPort": ${var.container_port},
        "containerPort": ${var.container_port},
        "protocol": "${var.container_proto}"
      }
    ],
    "environment": [
      { "name": "S3_BUCKET", "value": "${var.s3_bucket_name}" },
      { "name": "AWS_DEFAULT_REGION", "value": "${data.aws_region.current.name}" },
      { "name": "APP_NAME", "value": "${var.name}" },
      { "name": "APP_PORT", "value": "${var.container_port}" }
    ],
    "mountPoints": [
      {
        "sourceVolume": "${var.name}",
        "containerPath": "${var.container_path}"
      }
    ]
  }
]
EOT
}