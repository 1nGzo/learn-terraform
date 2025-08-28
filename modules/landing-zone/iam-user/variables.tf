variable "user_name" {
  description = "The iam user name."
  type = list(string)
  default = ["neo","trinity","morpheus"]
}

variable "give_neo_cloudwatch_full_access" {
  description = "If true, neo gets full access to cloudwatch."
  type = bool
}
