
output "alb_security_group_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = aws_security_group.alb.id
}

output "app_security_group_id" {
  description = "Security Group ID for application EC2 instances"
  value       = aws_security_group.app.id
}

output "db_security_group_id" {
  description = "Security Group ID for the RDS database"
  value       = aws_security_group.db.id
}
