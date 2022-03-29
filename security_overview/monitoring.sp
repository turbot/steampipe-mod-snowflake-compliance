variable "password_rotation_age" {
  type        = number
  description = "The maximum number of days users are allowed to use same password for login."
  default     = 90
}

benchmark "security_overview_monitoring" {
  title         = "Monitoring"
  description   = "Monitor the usage of Snowflake to meet organization's audit and compliance requirements."
  documentation = file("./security_overview/docs/monitoring.md")
  children = [
    control.security_overview_monitoring_users_for_password_rotation
  ]
}

control "security_overview_monitoring_users_for_password_rotation" {
  title       = "User passwords should be rotated at regular intervals"
  description = "User passwords should be rotated at regular intervals to remain compliant."
  sql         = query.monitoring_user_password_last_set_time_age.sql
  param "password_rotation_age" {
    default = var.password_rotation_age
  }
}
