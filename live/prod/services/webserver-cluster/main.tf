provider "aws" {
  region = "us-east-1"
}

module "db" {
  source = "../../../../modules/data-stores/mysql"
  
  db_username = var.db_username
  db_password = var.db_password

}


module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  db_address = module.db.address
  db_port = module.db.port
  cluster_name = "webserver-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-for-test"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  custom_tags = {
    Owner = "Demo"
    ManagedBy = "terraform"
  }
  enable_autoscaling = false
}
