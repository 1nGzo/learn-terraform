variable "backup_retention_period" {
  description = "Days to retain backups. Must be >0  to enable replication."
  type = number
  default = null
}

variable "replicate_source_db" {
  description = "If specified, replicate the RDS database at the given ARN."
  type = string
  default = null
}

variable "db_name" {
  description = "The name of DB"
  type = string
  default = "example-db"
}

variable "db_username" {
  description = "The username of db"
  type = string
  default = "jungle"
}

variable "db_password" {
  description = "The password of db"
  type = string
  sensitive = true
  default = null
}
