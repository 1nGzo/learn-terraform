provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "/home/ingzo28/learn-terraform-get-started-aws/modules/services/webserver-cluster"

  cluster_name = "webserver-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-for-test"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 2
}
