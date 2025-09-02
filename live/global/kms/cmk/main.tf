#本模组用于创建CMK以加密机密信息（DB密码等）

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "self" {}

data "aws_iam_policy_document" "cmk_admin_policy" {
  statement {
    effect = "Allow"
    resources = ["*"]
    actions = ["kms:*"]
    principals {
      type = "AWS"
      identifiers = [data.aws_caller_identity.self.arn]
    }
  }
}

resource "aws_kms_key" "cmk" {
  policy = data.aws_iam_policy_document.cmk_admin_policy.json
}

#默认KMS/CMK只有一个数字标识符，因此建议创建别名如下：
resource "aws_kms_alias" "cmk" {
  name = "alias/kms-cmk-example"
  target_key_id = aws_kms_key.cmk.id
}


