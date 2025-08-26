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

