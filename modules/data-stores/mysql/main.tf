resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t4g.micro"
  skip_final_snapshot = true
  db_name = "example_database"

  username = local.db_creds.username
  password = local.db_creds.username
}

# use this to decrypt secret
data "aws_kms_secrets" "creds" {
  secret {
    name = "db"
    payload = file("${path.module}/db-creds.yml.encrypted")
  }
  locals {
    db_creds = yamldecode(data.aws_kms_secrets.creds.plaintext["db"])
  }
}


