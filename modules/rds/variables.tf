variable "name" {
  description = "Project name used for RDS resource naming"
  type        = string
}

variable "db_subnet_ids" {
  description = "Private database subnet IDs"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "Security Group ID for RDS"
  type        = string
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "dbadmin"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated database storage in GB"
  type        = number
  default     = 20
}

variable "final_snapshot_identifier" {
  description = "Identifier for the final RDS snapshot"
  type        = string
}