# RDS DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}

# Amazon RDS MySQL Instance
resource "aws_db_instance" "main" {
  identifier = "${var.name}-mysql"

  engine         = "mysql"
  engine_version = "8.0"
  backup_window  = "18:00-19:00"

  instance_class    = var.db_instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username

  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_security_group_id]

  publicly_accessible = false

  multi_az                = false
  backup_retention_period = 0

  auto_minor_version_upgrade = true
  deletion_protection        = true
  skip_final_snapshot        = false
  final_snapshot_identifier  = var.final_snapshot_identifier

  tags = {
    Name = "${var.name}-mysql"
    Tier = "Database"
  }
}