module "ecs_apps" {
  source                  = "../"

  name                    = "jenkins-blueocean"
  instance_types          = ["t3a.small","t2.small","t3.small"]
  vpc_id                  = "vpc-1cb3f364"
  public_subnet_ids       = ["subnet-8f9f2ea0","subnet-f5126ebe"]
  s3_bucket_name          = "ecs-us-east-1-jenkins-storage"
  # Task Details (create custom defination to modify more details or add more containers)
  image                   = "jenkins/jenkins:latest"
  container_port          = 8080
  container_path          = "/var/jenkins_home"
  # If you are disabling EFS make sure you create and custom task defination
  create_efs              = true
  # Below is in UTC
  enable_schedule         = true
  schedule_cron_start     = "30 21 * * 0-4"
  schedule_cron_stop      = "0 13 * * 1-5"
}
