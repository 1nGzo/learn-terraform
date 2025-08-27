variable "user_name" {
  description = "The name of iam users."
  type = list(string)
  default = [ "neo","morpheus","trinity" ]
}
