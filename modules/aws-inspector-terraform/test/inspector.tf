module "aws_inspector" 
{
  source = "../../../."
  enabled = true
  name_prefix = "sandbox"
  enable_scheduled_event = true
  schedule_expression = "rate(90 days)"
  assessment_duration = "3600"
  inspector_use_tags = {
    SecurityScan = "AWS-Inspector-krishna"
  }
  inspector_rules_packages = [
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-rD1z6dpl",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ",
  ]
  tags = {
    environment = "dev"
    service = "aws-inspector"
    version = "v1"
    Terraform = "true"
    Initiator = "Terraform"
  }
}
