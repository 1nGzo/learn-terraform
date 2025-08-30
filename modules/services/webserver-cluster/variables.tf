variable "ami" {
  description = "The AMI to run instance."
  type = string
  default = "ami-0360c520857e3138f"
}

variable "instance_name" {
  description = "Value of the ec2 instance's name tag."
  type        = string
  default     = "terraform4test"
}

variable "server_text" {
  description = "The text the webserver should return."
  type = string
  default = "Hello, World"
}

variable "instance_type" {
  description = "The ec2 instance's type."
  type        = string
  default = "t2.micro"
}

variable "min_size" {
  description = "The minimum size of EC2 instance in the ASG."
  type        = number
  default = 2
}

variable "max_size" {
  description = "The maximum size of EC2 instance in the ASG."
  type        = number
  default = 2
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

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG."
  type = map(string)
  default = {}
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling."
  type = bool
}

