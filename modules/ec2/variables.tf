
variable "name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "app_subnet_ids" {
  description = "Private application subnet IDs"
  type        = list(string)
}

variable "app_security_group_id" {
  description = "Security Group ID for application instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 2
}

variable "target_group_arns" {
  description = "Target Group ARNs associated with the Auto Scaling Group"
  type        = list(string)
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository that EC2 can pull images from"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository containing the application image"
  type        = string
}

variable "aws_region" {
  description = "AWS region used by the EC2 instances"
  type        = string
}


variable "image_tag" {
  description = "Docker image tag deployed from ECR"
  type        = string
  default     = "v1"
}