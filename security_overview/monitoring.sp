variable "password_rotation_age" {
  type        = number
  description = "The maximum number of days users are allowed to use same password for login."
  default     = 90
}

benchmark "security_overview_monitoring" {
  title       = "Monitoring"
  description = "Once your Snowflake account is accessible, the next step in gaining access to Snowflake is to authenticate the user. Users must be created in Snowflake prior to any access. Once the user is authenticated, a session is created with roles used to authorize access in Snowflake. \nThis section covers best practices for: \n- Managing users and roles\n- Authentication and single sign-on\n- Sessions\n- Object-level access control (authorization)\n- Column-level access control\n- Row-level access control"
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
