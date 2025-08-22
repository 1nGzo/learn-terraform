variable "instance_name" {
  description = "Value of the ec2 instance's name tag."
  type        = string
  default     = "learn-terraform"
}

variable "instance_type" {
  description = "The ec2 instance's type."
  type        = string
  default     = "t2.micro"
}
