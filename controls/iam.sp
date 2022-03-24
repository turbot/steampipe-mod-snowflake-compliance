benchmark "iam" {
  title       = "Identity and Access Management"
  description = "Once your Snowflake account is accessible, the next step in gaining access to Snowflake is to authenticate the user. Users must be created in Snowflake prior to any access. Once the user is authenticated, a session is created with roles used to authorize access in Snowflake. \nThis section covers best practices for: \n- Managing users and roles\n- Authentication and single sign-on\n- Sessions\n- Object-level access control (authorization)\n- Column-level access control\n- Row-level access control"
  children = [
    control.user_with_has_password,
  ]
}

control "user_with_has_password" {
  title       = "For users who don't require a password in Snowflake, set the password property to null."
  description = "For users who don't require a password in Snowflake, set the password property to null. This will ensure that the password as an authentication method isn't available to those users, and they can't set the password themselves."
  # docs = ""
  sql = <<EOT
    select
      name as resource,
      case
        when has_password then 'alarm'
        else 'ok'
      end as status,
      case
        when has_password then name || ' has password set.'
        else name || ' does not have password set.'
      end as reason
    from
      snowflake_user
    EOT
}
