provider "aws" {
  version = "= 3.21.0"
  region = var.region
}

terraform {
  backend "s3" {}
  required_version = "= 0.13.0"
}

module "label" {
  source = "git::https://github.com/uniquetech/property_trans_analytics.git"
  purpose = var.purpose
  environment = var.environment
  region_code = var.region_code
}

module "python_ecs_example" {
  source = "./modules/python_ecs_example"
  name = module.label.name
  tags = module.label.tags
  region = var.region
  ecs_cluster_arn = var.ecs_cluster_arn
  subnet_ids = var.subnet_ids
  security_group_ids = var.security_group_ids
}
