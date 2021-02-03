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
variable "engine" {
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
  type        = string
  default     = "aurora"
}
variable "engine_version" {
  description = "Aurora database engine version."
  type        = string
  default     = "5.6.10a"
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

variable "password" {
  description = "Master DB password"
  type        = string
  default     = ""
}