terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-for-test"
    region = "us-east-1"
    key = "stage/services/webserver_cluster/terraform.tfstate"
    encrypt = true
    dynamodb_table = "terraform-up-and-runing-locks"
  }
}

