#===============================================================================
# DB CLUSTER
#===============================================================================
locals {
  cluster_identifier        = var.cluster_use_identifier_prefix ? null : var.cluster_identifier
  cluster_identifier_prefix = var.cluster_use_identifier_prefix ? "${var.cluster_identifier_prefix}-" : null
}

resource "aws_rds_cluster" "postgresql" {
  count = var.create ? 1 : 0

  cluster_identifier        = local.cluster_identifier
  cluster_identifier_prefix = local.cluster_identifier_prefix

  engine             = var.engine
  availability_zones = var.availability_zones

  database_name               = var.database_name
  master_username             = var.master_username
  master_password             = var.manage_master_user_password ? null : var.master_password
  manage_master_user_password = var.manage_master_user_password
  port                        = var.port

  engine_version            = var.engine_version
  db_cluster_instance_class = var.db_cluster_instance_class
  allocated_storage         = var.allocated_storage
  storage_type              = var.storage_type
  iops                      = var.iops
  storage_encrypted         = var.storage_encrypted 
  kms_key_id                = var.kms_key_id        

  backup_retention_period  = var.backup_retention_period
  delete_automated_backups = var.delete_automated_backups
  deletion_protection      = var.deletion_protection
  preferred_backup_window  = var.preferred_backup_window

  vpc_security_group_ids = var.vpc_security_group_ids 

  skip_final_snapshot = var.skip_final_snapshot
  tags                = var.tags

}