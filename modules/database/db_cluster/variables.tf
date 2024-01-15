#===============================================================================
# DB CLUSTER
#===============================================================================
variable "create" {
  description = "Flag to determine if the resource should be created"
  type        = bool
  default     = false
}

variable "cluster_use_identifier_prefix" {
  description = "Flag to determine whether to use the identifier prefix or not"
  type        = bool
  default     = false
}

variable "cluster_identifier" {
  description = "Cluster identifier for the resource"
  type        = string
}

variable "cluster_identifier_prefix" {
  description = "Prefix for the resource identifier"
  type        = string
}

variable "engine" {
  description = "Engine for the resource"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the database cluster"
  type        = list(string)
}

variable "database_name" {
  description = "The name of the database"
  type        = string
}

variable "master_username" {
  description = "The username for the database"
  type        = string
}

variable "master_password" {
  description = "The password for the database"
  type        = string
}

variable "manage_master_user_password" {
  description = "Flag to indicate whether to manage the master user password"
  type        = bool
}

variable "port" {
  description = "The port number for the database"
  type        = number
}

variable "engine_version" {
  description = "Version of the engine"
  type        = string
}

variable "db_cluster_instance_class" {
  description = "Instance class for the resource"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for the resource"
  type        = number
}

variable "storage_type" {
  description = "Type of storage for the resource"
  type        = string
}

variable "storage_encrypted" {
  description = "Flag to determine if storage is encrypted"
  type        = bool
}

variable "kms_key_id" {
  description = "KMS key ID for encryption"
  type        = string
}

variable "iops" {
  description = "Input/Output Operations Per Second (IOPS) for storage"
  type        = number
}

variable "skip_final_snapshot" {
  description = "Flag to indicate whether to skip the final database snapshot"
  type        = bool
}

variable "backup_retention_period" {
  description = "Retention period for automated backups"
  type        = number
}

variable "delete_automated_backups" {
  description = "Flag to indicate whether to delete automated backups"
  type        = bool
}

variable "deletion_protection" {
  description = "Flag to indicate whether to enable deletion protection"
  type        = bool
}

variable "preferred_backup_window" {
  description = "Preferred window for database backups"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "IDs dos grupos de segurança da VPC"
  type        = list(string)
  default     = var.vpc_security_group_ids
}


variable "tags" {
  type        = map(string)
  description = "The common tags for all resources"
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

