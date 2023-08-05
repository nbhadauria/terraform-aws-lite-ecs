resource "aws_efs_file_system" "ecs" {
  count          = var.create_efs ? 1 : 0
  creation_token = "ecs-${var.name}"
  encrypted      = true

  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps

  tags = {
    Name   = "ecs-${var.name}"
    Backup = var.backup
  }
}

resource "aws_efs_mount_target" "ecs" {
  count          = var.create_efs ? length(var.public_subnet_ids) : 0
  file_system_id = aws_efs_file_system.ecs[0].id
  subnet_id      = element(var.public_subnet_ids, count.index)

  security_groups = [
    aws_security_group.efs[0].id
  ]

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_security_group" "efs" {
  count       = var.create_efs ? 1 : 0
  name        = "ecs-${var.name}-efs"
  description = "for EFS to talk to ECS cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ecs-efs-${var.name}"
  }
}

resource "aws_security_group_rule" "nfs_from_ecs_to_efs" {
  count                    = var.create_efs ? 1 : 0
  description              = "ECS to EFS"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.efs[0].id
  source_security_group_id = aws_security_group.ecs_nodes.id
}