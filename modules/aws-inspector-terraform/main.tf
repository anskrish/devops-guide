terraform {
  required_version = ">= 0.13"
  required_providers {
   aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  enabled_count = var.enabled ? 1 : 0
  scheduled_count = var.enable_scheduled_event && var.enabled ? 1 : 0
}

data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "inspector_event_role_policy" {
  count = local.scheduled_count
  statement {
    sid = "StartAssessment"
    actions = [
      "inspector:StartAssessmentRun",
    ]
    resources = [
      "*"
    ]
  }
}
resource "aws_inspector_resource_group" "group" {
  tags = var.inspector_use_tags
}
resource "aws_inspector_assessment_target" "assessment" {
  count = local.enabled_count
  name = "${var.name_prefix}-assessment-target"
  resource_group_arn = aws_inspector_resource_group.group.arn
}

resource "aws_inspector_assessment_template" "assessment" {
  count = local.enabled_count
  name = "${var.name_prefix}-assessment-template"
  target_arn = var.enabled ? aws_inspector_assessment_target.assessment[0].arn : ""
  duration = var.assessment_duration
  rules_package_arns = var.inspector_rules_packages
  tags = var.tags
}

resource "aws_iam_role" "inspector_event_role" {
  count = local.scheduled_count
  name = "${var.name_prefix}-inspector-event-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "inspector_event" {
  count = local.scheduled_count
  name = "${var.name_prefix}-inspector-event-policy"
  role = aws_iam_role.inspector_event_role[0].id
  policy = data.aws_iam_policy_document.inspector_event_role_policy[0].json
}

resource "aws_cloudwatch_event_rule" "inspector_event_schedule" {
  count = local.scheduled_count
  name = "${var.name_prefix}-inspector-schedule"
  description = "Trigger an Inspector Assessment"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "inspector_event_target" {
  count = local.scheduled_count
  rule = aws_cloudwatch_event_rule.inspector_event_schedule[0].name
  arn = aws_inspector_assessment_template.assessment[0].arn
  role_arn = aws_iam_role.inspector_event_role[0].arn
}
