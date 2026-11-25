
output "vpc_id" {
  description = "Created VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "app_subnet_ids" {
  value = module.vpc.app_subnet_ids
}

output "db_subnet_ids" {
  value = module.vpc.db_subnet_ids
}

output "availability_zones" {
  value = module.vpc.availability_zones
}

output "autoscaling_group_name" {
  description = "Application Auto Scaling Group name"
  value       = module.ec2.autoscaling_group_name
}

output "launch_template_id" {
  description = "Application Launch Template ID"
  value       = module.ec2.launch_template_id
}

output "ec2_iam_role_arn" {
  description = "EC2 IAM Role ARN"
  value       = module.ec2.iam_role_arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "target_group_arn" {
  description = "ARN of the application Target Group"
  value       = module.alb.target_group_arn
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
}

output "rds_address" {
  description = "RDS database hostname"
  value       = module.rds.db_address
}

output "rds_port" {
  description = "RDS database port"
  value       = module.rds.db_port
}

output "rds_identifier" {
  description = "RDS database identifier"
  value       = module.rds.db_identifier
}


output "ecr_repository_name" {
  description = "Sudoku ECR repository name"
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "Sudoku ECR repository URL"
  value       = module.ecr.repository_url
}

output "ecr_repository_arn" {
  description = "Sudoku ECR repository ARN"
  value       = module.ecr.repository_arn
}
