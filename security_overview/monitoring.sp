variable "password_age_max_days" {
  type        = number
  description = "The maximum number of days a password can be used before the user is required to change it."
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
  title         = "User passwords should be rotated at regular intervals"
  description   = "User passwords should be rotated at regular intervals to remain compliant."
  documentation = file("./security_overview/docs/monitoring_users_for_password_rotation.md")
  sql           = query.monitoring_user_password_rotated_regularly.sql

  param "password_age_max_days" {
    default = var.password_age_max_days
  }
}
