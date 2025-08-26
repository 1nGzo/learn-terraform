variable "instance_name" {
  description = "Value of the ec2 instance's name tag."
  type        = string
  default     = "learn-terraform"
}

variable "instance_type" {
  description = "The ec2 instance's type."
  type        = string
}

variable "min_size" {
  description = "The minimum size of EC2 instance in the ASG."
  type        = number
}

variable "max_size" {
  description = "The maximum size of EC2 instance in the ASG."
  type        = number
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources."
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the s3 bucket for the database's remote state."
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in s3."
  type        = string
}

variable "db_address" {
  description = "The address of the database."
  type = string
}

variable "db_port" {
  description = "The port of the database."
  type = string
}
