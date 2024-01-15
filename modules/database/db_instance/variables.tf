#===============================================================================
# VARAIBLES DB SINGLE INSTANCE
#===============================================================================
variable "create" {
  description = "Flag to determine if resource should be created"
  type        = bool
  default     = false
}

variable "use_identifier_prefix" {
  description = "Flag to determine whether to use the identifier prefix or not"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "Identifier for the resource"
  type        = string
}

variable "identifier_prefix" {
  description = "Prefix for the resource identifier"
  type        = string
}

variable "is_replica" {
  description = "Flag to determine if it's a replica"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Engine for the resource"
  type        = string
}

variable "engine_version" {
  description = "Version of the engine"
  type        = string
}

variable "instance_class" {
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

variable "license_model" {
  description = "License model for the resource"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
}

variable "username" {
  description = "The username for the database"
}

variable "password" {
  description = "The password for the database"
}

variable "manage_master_user_password" {
  description = "Flag to indicate whether to manage the master user password"
}

variable "port" {
  description = "The port number for the database"
}

variable "skip_final_snapshot" {
  description = "Flag to indicate whether to skip the final database snapshot"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs associated with the VPC."
}

variable "db_subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group for the database."
}

variable "parameter_group_name" {
  type        = string
  description = "The name of the DB parameter group for the database."
}

variable "option_group_name" {
  type        = string
  description = "The name of the DB option group for the database."
}

variable "network_type" {
  type        = string
  description = "The type of network for the database (e.g., 'standard', 'io1')."
}

variable "availability_zone" {
  type        = string
  description = "The availability zone in which to launch the DB instance."
}

variable "multi_az" {
  type        = bool
  description = "Indicates whether the database instance is a Multi-AZ deployment."
}

variable "iops" {
  type        = number
  description = "The amount of provisioned IOPS for the DB instance (input as an integer)."
}

variable "storage_throughput" {
  type        = number
  description = "The amount of storage throughput for the DB instance (input as an integer)."
}

variable "publicly_accessible" {
  type        = bool
  description = "Determines if the DB instance is publicly accessible."
}

variable "ca_cert_identifier" {
  type        = string
  description = "The identifier of the certificate authority (CA) certificate for the DB instance."
}


