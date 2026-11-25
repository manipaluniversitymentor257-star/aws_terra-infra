variable "name" {
  description = "Project name used for ALB resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security Group ID attached to the ALB"
  type        = string
}

variable "app_port" {
  description = "Port on which application instances listen"
  type        = number
  default     = 8080
}