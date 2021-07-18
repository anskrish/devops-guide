module "inspector_production" {
  source = "../../../../modules/aws-inspector/."
  enabled = var.inspector_enabled
  name_prefix = var.name_prefix
  enable_scheduled_event = var.enable_scheduled_event
  schedule_expression = var.schedule_expression
  assessment_duration = var.assessment_duration
  inspector_use_tags = var.inspector_use_tags
  inspector_rules_packages = var.inspector_rules_packages
  tags = var.tags
}
