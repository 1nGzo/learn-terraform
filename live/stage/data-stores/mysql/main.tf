provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t4g.micro"
  skip_final_snapshot = true
  db_name = "example_database"

  #在这里引用变量来避免明文显示用户名/密码
  username = var.db_username
  password = var.db_password
}

terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-for-test"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-up-and-runing-locks"
    encrypt = true
  }
}
