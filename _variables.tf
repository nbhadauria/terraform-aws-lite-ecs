variable "name" {
  description = "Name of this ECS cluster."
}

variable "instance_types" {
  description = "Instance type for ECS workers"
  type        = list(any)
  default     = []
}

variable "on_demand_percentage" {
  description = "Percentage of on-demand intances vs spot."
  default     = 0
}

variable "on_demand_base_capacity" {
  description = "You can designate a base portion of your total capacity as On-Demand. As the group scales, per your settings, the base portion is provisioned first, while additional On-Demand capacity is percentage-based."
  default     = 0
}

variable "vpc_id" {
  description = "VPC ID to deploy the ECS cluster."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for ECS and EFS."
}

variable "architecture" {
  default     = "x86_64"
  description = "Architecture to select the AMI, x86_64 or arm64"
}

variable "volume_type" {
  default     = "gp2"
  description = "The EBS volume type"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "Extra security groups for instances."
}

variable "security_group_ecs_nodes_outbound_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "ECS Nodes outbound allowed CIDRs for the security group."
}

variable "userdata" {
  default     = ""
  description = "Extra commands to pass to userdata."
}

variable "autoscaling_health_check_grace_period" {
  default     = 300
  description = "The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service."
}

variable "instance_volume_size" {
  description = "Volume size for docker volume (in GB)."
  default     = 30
}

variable "enable_schedule" {
  default     = false
  description = "Enables schedule to shut down and start up instances outside business hours."
}

variable "schedule_cron_start" {
  type        = string
  default     = ""
  description = "Cron expression to define when to trigger a start of the auto-scaling group. E.g. '0 20 * * *' to start at 8pm GMT time."
}

variable "schedule_cron_stop" {
  type        = string
  default     = ""
  description = "Cron expression to define when to trigger a stop of the auto-scaling group. E.g. '0 10 * * *' to stop at 10am GMT time."
}

variable "throughput_mode" {
  type        = string
  default     = "bursting"
  description = "Throughput mode for the file system. Defaults to bursting. Valid values: bursting, provisioned."
}

variable "provisioned_throughput_in_mibps" {
  default     = 0
  description = "The throughput, measured in MiB/s, that you want to provision for the file system."
}

variable "alarm_prefix" {
  type        = string
  description = "String prefix for cloudwatch alarms. (Optional)"
  default     = "alarm"
}

variable "create_iam_service_linked_role" {
  type        = bool
  default     = false
  description = "Create iam_service_linked_role for ECS or not."
}

variable "ec2_key_enabled" {
  default     = false
  description = "Generate a SSH private key and include in launch template of ECS nodes"
}

variable "vpn_cidr" {
  default     = ["10.37.0.0/16"]
  description = "Cidr to grant ssh access to ECS nodes"
}

variable "create_efs" {
  type        = bool
  default     = true
  description = "Enables creation of EFS volume for cluster"
}

variable "extra_task_policies_arn" {
  type        = list(string)
  default     = []
  description = "Extra policies to add to the task definition permissions"
}

variable "container_insights" {
  type        = bool
  default     = false
  description = "Enables CloudWatch Container Insights for a cluster."
}

variable "hosted_zone_is_internal" {
  default     = "false"
  description = "Set true in case the hosted zone is in an internal VPC, otherwise false"
}

variable "hosted_zone" {
  default     = ""
  description = "Hosted Zone to create DNS record for this app"
}

variable "hosted_zone_id" {
  default     = ""
  description = "Hosted Zone ID to create DNS record for this app (use this to avoid data lookup when using `hosted_zone`)"
}

variable "hostname_create" {
  default     = "false"
  description = "Optional parameter to create or not a Route53 record"
}

variable "hostnames" {
  default     = []
  description = "List of hostnames to create DNS records for this app"
}

variable "create_s3_bucket" {
  default     = "false"
  description = "create an s3 bucket for tasks to use"
}

variable "s3_bucket_name" {
  default     = ""
  description = "Hosted Zone ID to create DNS record for this app (use this to avoid data lookup when using `hosted_zone`)"
}

variable "image" {
  default     = "nginx:latest"
  description = "docker image"
}

variable "task_definition_arn" {
  default     = ""
  description = "task defination arn"
}

variable "container_port" {
  default     = "80"
  description = "Container Port"
}

variable "container_path" {
  default     = "/opt"
  description = "Container path to map efs volume"
}

variable "container_proto" {
  default     = "tcp"
  description = "Container proto"
}

variable "backup" {
  type        = string
  default     = "false"
  description = "Assing a backup tag to efs resource - Backup will be performed by AWS Backup."
}