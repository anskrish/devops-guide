variable "region" {
  description = "AWS EC2 Region"
  default = ""
}

variable "inspector_enabled" {
  description = "Inspector enable status"
  default = true
}

variable "name_prefix" {
  type = string
  description = "Prefix for resource names that terraform will create."
  default = ""
}

variable "enable_scheduled_event" {
  type = bool
  description = "Enable Cloudwatch Events to schedule an assessment."
  default = true
}

variable "schedule_expression" {
  type = string
  description = "AWS Schedule Expression: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  default = "cron(0 6 1 * ? *)" # Run every 90 days
}

variable "assessment_duration" {
  type = string
  description = "The duration of the Inspector assessment run."
  default = "3600" # 1 hour
}

variable "inspector_use_tags" {
  description = "tags to apply to all resources."
  type = map(string)
  default = {
    SecurityScan = ""
  }
}

variable "inspector_rules_packages" {
  description = "rules packages to apply."
  type = list(string)
  default = []
}

variable "tags" {
  description = "tags to apply to all resources"
  type = map(string)
  default = {}
}
