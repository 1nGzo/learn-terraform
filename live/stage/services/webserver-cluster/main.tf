provider "aws" {
  region = "us-east-1"
}

module "database" {
  source = "../../../../modules/data-stores/mysql"
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  server_text = "New server page 1"
  cluster_name = "webserver-stage"
  max_size = 3
  db_remote_state_bucket = "terraform-up-and-running-state-for-test"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  db_address = module.database.address
  db_port = module.database.port
  enable_autoscaling = false
}
