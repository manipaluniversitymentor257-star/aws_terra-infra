
variable "name" {
  description = "Project name used for security group naming"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "app_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Port on which the database listens"
  type        = number
  default     = 3306
}
