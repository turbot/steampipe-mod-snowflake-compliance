benchmark "monitoring" {
  title       = "Monitoring"
  description = "Once your Snowflake account is accessible, the next step in gaining access to Snowflake is to authenticate the user. Users must be created in Snowflake prior to any access. Once the user is authenticated, a session is created with roles used to authorize access in Snowflake. \nThis section covers best practices for: \n- Managing users and roles\n- Authentication and single sign-on\n- Sessions\n- Object-level access control (authorization)\n- Column-level access control\n- Row-level access control"
  children = [
    control.monitoring_users_with_password
  ]
}

# Get detailed info for users
# You can get detailed information on current users using the USERS account_usage view. With this view, you can query for:

# 1 Users that have passwords in Snowflake (where HAS_PASSWORD = true)
# 2 Users with passwords in Snowflake, if they are changing the password at regular intervals to remain compliant (where PASSWORD_LAST_SET_TIME > dateadd(day, -90, CURRENT_TIMESTAMP() -- hasn’t changed in the last 90 days).
# Users using keypair authentication (where HAS_RSA_PUBLIC_KEY = true)
# Users using SSO to connect into Snowflake (where HAS_PASSWORD != true and HAS_RSA_PUBLIC_KEY != true)
# Users created in the last 30 days (where CREATED_ON > dateadd(day, -30, CURRENT_TIMESTAMP())
# Inactive users (where LAST_SUCCESS_LOGIN >  dateadd(day, -30, CURRENT_TIMESTAMP() -- haven’t used Snowflake in the last 30 days)
# Disabled users (where DISABLED = true)

control "monitoring_users_with_password" {
  title       = "Users that have password"
  description = "For users who don't require a password in Snowflake, set the password property to null. This will ensure that the password as an authentication method isn't available to those users, and they can't set the password themselves."
  # docs = ""
  sql = query.password_last_set_time_age.sql
}

query "password_last_set_time_age" {
  sql = <<EOT
    select
      name as resource,
      case
        when now()::date - password_last_set_time::date > 90 then 'alarm'
        else 'ok'
      end as status,
      name || ' password was changed ' || (now()::date - password_last_set_time::date) || ' days ago'::text as reason
    from
      snowflake_user
    where
      has_password and password_last_set_time is not null;
  EOT
}
