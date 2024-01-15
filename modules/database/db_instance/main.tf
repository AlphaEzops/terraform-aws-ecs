#===============================================================================
# DB SINGLE INSTANCE
#===============================================================================
locals {
  identifier        = var.use_identifier_prefix ? null : var.identifier
  identifier_prefix = var.use_identifier_prefix ? "${var.identifier_prefix}-" : null
}

resource "aws_db_instance" "default" {
 count = var.create ? 1 : 0

  identifier        = local.identifier
  identifier_prefix = local.identifier_prefix

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  storage_encrypted = var.storage_encrypted   
  kms_key_id        = var.kms_key_id          
  license_model     = var.license_model       

  db_name                             = var.db_name
  username                            = var.username
  password                            = var.manage_master_user_password ? null : var.password
  manage_master_user_password         = var.manage_master_user_password
  port                                = var.port

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  parameter_group_name   = var.parameter_group_name
  option_group_name      = var.option_group_name
  network_type           = var.network_type

  availability_zone   = var.availability_zone
  multi_az            = var.multi_az
  iops                = var.iops
  storage_throughput  = var.storage_throughput
  publicly_accessible = var.publicly_accessible
  ca_cert_identifier  = var.ca_cert_identifier
  
  skip_final_snapshot              = var.skip_final_snapshot
}