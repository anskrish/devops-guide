region = "us-east-1"
inspector_enabled = true
name_prefix = "krishna-account1-us-east-1"
enable_scheduled_event = true
schedule_expression = "cron(0 7 1 * ? *)"
assessment_duration = "3600"
inspector_use_tags = {
    SecurityScan = "aws-inspector-krishna-account1-us-east-1"
  }
inspector_rules_packages = [
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-gEjTy7T7",
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-rExsr2X8",
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-PmNV0Tcd",
  ]
tags = {
    Environment = "krishna-account1"
    Initiator = "Terraform"
    Service = "infrastructure"
  }


