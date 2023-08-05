# terraform-aws-lite-ecs

This terraform module builds an Single Server ECS cluster for Non Prod use

The following resources will be created:

- ECS Task and Service
- Elastic File System (EFS)
- Auto Scaling (Support for Spot Instance)
- S3 Bucket to use in application
- Security groups for (EIP, ECS NODES)
- IAM roles and policies for the container instances

## Usage

```hcl
module "ecs_apps" {
  source               = "git::https://github.com/nbhadauria/terraform-aws-lite-ecs.git?ref=0.1.0"
  name                    = "sample-app"
  instance_types          = ["t3a.small","t2.small","t3.small"]
  vpc_id                  = "vpc-1cb3f364"
  public_subnet_ids       = ["subnet-8f9f2ea0","subnet-f5126ebe"]
  s3_bucket_name          = "ecs-us-east-1-sample-app-bucket"
  # Task Details (create custom definition to modify more details or add more containers)
  image                   = "apache:latest"
  container_port          = 80
  container_path          = "/opt"
  # If you are disabling EFS make sure you create and custom task definition
  create_efs              = true
  # Below is in UTC
  enable_schedule         = true
  schedule_cron_start     = "30 21 * * 0-4"
  schedule_cron_stop      = "0 13 * * 1-5"
}
```
