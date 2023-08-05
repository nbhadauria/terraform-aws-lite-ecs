resource "aws_ecs_cluster" "ecs" {
  name = var.name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs" {
  cluster_name = aws_ecs_cluster.ecs.name

  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]
}