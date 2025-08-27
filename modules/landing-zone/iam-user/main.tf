resource "aws_iam_user" "example" {
  name = var.user_name[count.index]
  count = length(var.user_name)
}
