output "ecs_name" {
  value = module.ecs_apps.ecs_name
}

output "ecs_nodes_secgrp_id" {
  value = module.ecs_apps.ecs_nodes_secgrp_id
}

output "public_ip" {
  value = module.ecs_apps.public_ip
}