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

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
}

variable  "server_port" {
  description = "The Instance Server port"
  type = number
  default = 80
}