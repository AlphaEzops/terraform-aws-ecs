#===============================================================================
# DB INSTANCE VARIABLES
#===============================================================================
variable "db_instance_count" {
  description = "Number of database instances"
  type        = number
  default     = 1
}

variable "allocated_storage" {
  description = "Allocated space for the database"
  type        = number
  default     = 10
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "mydb"
}

variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "5.7"
}

variable "instance_class" {
  description = "Database instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "foo"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "foobarbaz"
}

variable "parameter_group_name" {
  description = "Name of the database parameter group"
  type        = string
  default     = "default.mysql5.7"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying the instance"
  type        = bool
  default     = true
}
