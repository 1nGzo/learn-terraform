output "user_arn" {
  value = values(aws_iam_user.example)[*].arn
  description = "The ARN of the created iam user."
}

output "neo_cloudwatch_policy_arn" {
  value = one(concat(
    aws_iam_policy_attachment.neo_cloudwatch_full_access[*].policy_arn,
    aws_iam_policy_attachment.neo_cloudwatch_read_only[*].policy_arn
  ))
}
