#provider "aws" {
#  region = "us-west-2"
#	profile= "QA-AUNA"
#}

######################################
# Data sources to get VPC and subnets
######################################
data "aws_vpc" "default" {
#  default = true
  id = var.vpc_id
}

# data "aws_subnet_ids" "all" {
#   vpc_id = data.aws_vpc.default.id
# }

#############
# RDS Aurora
#############
module "aurora" {
#  source                          = "../../"
  source                          = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 3.0"
#  name                            = "aurora-example-postgresql"
  name                            = var.name
#  engine                          = "aurora-postgresql"
  engine                          = var.engine
#  engine_version                  = "11.6"
  engine_version                  = var.engine_version
#  subnets                         = data.aws_subnet_ids.all.ids           ####check this dont have subnets values
  subnets                         = var.subnet_ids
  vpc_id                          = data.aws_vpc.default.id
#  replica_count                   = 2
  replica_count                   = 2
#  instance_type                   = "db.r4.large"
  instance_type                   = var.instance_type
#  instance_type_replica           = "db.t3.medium"
  instance_type_replica           = var.instance_type_replica
#  apply_immediately               = true
  apply_immediately               = true
#  skip_final_snapshot             = true
  skip_final_snapshot             = true
  db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgres11_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgres11_parameter_group.id
  #  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
#  security_group_description = ""
  security_group_description = ""
}

resource "aws_db_parameter_group" "aurora_db_postgres11_parameter_group" {
  name        = "test-aurora-db-postgres11-parameter-group"
  family      = "aurora-postgresql11"
  description = "test-aurora-db-postgres11-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres11_parameter_group" {
  name        = "test-aurora-postgres11-cluster-parameter-group"
  family      = "aurora-postgresql11"
  description = "test-aurora-postgres11-cluster-parameter-group"
}

############################
# Example of security group
############################
resource "aws_security_group" "app_servers" {
  name_prefix = "app-servers-"
  description = "For application servers"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "allow_access" {
  type                     = "ingress"
  from_port                = module.aurora.this_rds_cluster_port
  to_port                  = module.aurora.this_rds_cluster_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_servers.id
  security_group_id        = module.aurora.this_security_group_id
}
