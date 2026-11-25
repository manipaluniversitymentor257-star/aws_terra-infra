
variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "ap-south-1"
}


variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "aws-terra-infra"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnet internet access"
  type        = bool
  default     = true
}

variable "az_count" {
  description = "Number of Availability Zones"
  type        = number
  default     = 2
}


variable "image_tag" {
  description = "Docker image tag deployed from ECR"
  type        = string
  default     = "v1"
}