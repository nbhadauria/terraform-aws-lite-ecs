output "ecs_iam_role_arn" {
  value = aws_iam_role.ecs.arn
}

output "ecs_iam_role_name" {
  value = aws_iam_role.ecs.name
}

output "ecs_service_iam_role_arn" {
  value = aws_iam_role.ecs_service.arn
}

output "ecs_service_iam_role_name" {
  value = aws_iam_role.ecs_service.name
}

output "ecs_task_iam_role_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "ecs_task_iam_role_name" {
  value = aws_iam_role.ecs_task.name
}

output "ecs_id" {
  value = aws_ecs_cluster.ecs.id
}

output "ecs_arn" {
  value = aws_ecs_cluster.ecs.arn
}

output "ecs_name" {
  value = aws_ecs_cluster.ecs.name
}

output "ecs_nodes_secgrp_id" {
  value = aws_security_group.ecs_nodes.id
}

output "public_ip" {
  value = aws_eip.this.public_ip
}