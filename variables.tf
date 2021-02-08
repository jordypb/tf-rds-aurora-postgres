variable "publicly_accessible" {
  description = "Whether the DB should have a public IP address"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}
# DB subnet group
variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name given resources"
  type        = string
  default     = ""
}
variable "username" {
  description = "Master DB username"
  type        = string
  default     = ""
}
variable "create_random_password" {
  description = "Whether to create random password for RDS primary cluster"
  type        = bool
  default     = true
}
variable "password" {
  description = "Master DB password"
  type        = string
#  default     = ""
}
variable "port" {
  description = "The port on which to accept connections"
  type        = string
  default     = ""
}
variable "engine" {
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
  type        = string
  default     = ""
}
variable "engine_version" {
  description = "Aurora database engine version."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type to use at master instance. If instance_type_replica is not set it will use the same type for replica instances"
  type        = string
  default     = ""
}
variable "instance_type_replica" {
  description = "Instance type to use at replica instance"
  type        = string
  default     = ""
}
variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = false
}
variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "When to perform DB backups"
  type        = string
  default     = "02:00-03:00"
}

variable "preferred_maintenance_window" {
  description = "When to perform DB maintenance"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
variable "environment" {
  description = "environment of deploy"
  type        = string
  default     = ""
}
variable "replica_count" {
  description = "Number of reader nodes to create. ###If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
  type        = number
  default     = 1  
}
