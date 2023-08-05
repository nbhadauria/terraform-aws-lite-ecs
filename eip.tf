resource "aws_eip" "this" {
  domain        = "vpc"
  tags          = { Name = "ecs-eip-${var.name}" }
}