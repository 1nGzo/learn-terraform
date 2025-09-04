provider "aws" {
  region = "us-east-1"
  alias = "primary"
}

provider "aws" {
  region = "us-west-1"
  alias = "replica"
}

module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"
  providers = {
    aws = aws.primary
  }
  db_name = "prod_db"
  db_password = var.db_password
  
  #Must be enabled to support replication
  backup_retention_period = 1
}

module "mysql_replica" {
  source = "../../../../modules/data-stores/mysql"
  providers = {
    aws = aws.replica
  }
  #Make this a replica of the primary
  replicate_source_db = module.mysql_primary.arn
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
