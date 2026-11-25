
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "app_subnet_ids" {
  description = "IDs of application subnets"
  value       = [for subnet in aws_subnet.app : subnet.id]
}

output "db_subnet_ids" {
  description = "IDs of database subnets"
  value       = [for subnet in aws_subnet.db : subnet.id]
}

output "availability_zones" {
  description = "Selected Availability Zones"
  value       = local.azs
}
