provider "aws" {
  region = local.region
}

locals {
  name   = "dev1"
  region = "us-east-1"
  tags = {
    Managed = "Terraform"
    Environment = "dev1"
  }
}



module "db" {
  source = "../."

  identifier = local.name

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "postgres"
  engine_version       = "13.2"
  family               = "postgres13" # DB parameter group
  major_engine_version = "13"         # DB option group
  instance_class       = "db.m5.xlarge"

  allocated_storage     = 19
  max_allocated_storage = 1000
  storage_encrypted     = true

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  name     = "dev1"
  username = "plate_ops"
  password = "adssmainsdsi"
  port     = 5432

  multi_az = false
  subnet_ids  = ["subnet-xxsds601sdc356e", "subnet-xcxsd1072dsdsd", "subnet-sdsdf802fdff739" ,"subnet-dsds80b8772dsds"]
  vpc_security_group_ids = ["sg-e5450d99baa6dsds"]

  maintenance_window = "thu:07:38-thu:08:08"
  backup_window = "00:00-00:30"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  auto_minor_version_upgrade = false

  backup_retention_period = 7
  skip_final_snapshot = true
  deletion_protection = false
  copy_tags_to_snapshot = true

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  tags = local.tags
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
}
