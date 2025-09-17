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

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG."
  type = map(string)
  default = {}
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling."
  type = bool
}

variable "subnet_ids" {
  description = "The subnet IDs to deploy to"
  type        = list(string)
}

variable "target_group_arns" {
  description = "The ARNs of ELB target groups in which to register Instances"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "The type of health check to perform. Must be one of: EC2, ELB."
  type        = string
  default     = "EC2"
}

variable "user_data" {
  description = "The User Data script to run in each Instance at boot"
  type        = string
  default     = null
}

