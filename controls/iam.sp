benchmark "iam" {
  title       = "Identity and Access Management"
  description = "Once your Snowflake account is accessible, the next step in gaining access to Snowflake is to authenticate the user. Users must be created in Snowflake prior to any access. Once the user is authenticated, a session is created with roles used to authorize access in Snowflake. \nThis section covers best practices for: \n- Managing users and roles\n- Authentication and single sign-on\n- Sessions\n- Object-level access control (authorization)\n- Column-level access control\n- Row-level access control"
  children = [
    control.iam_user_has_password,
    control.iam_user_with_buillt_in_duo_mfa,
    control.iam_user_default_role_is_set,
  ]
}

# Shall we restrict such queries by no of days we are looking for
control "iam_user_has_password" {
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

control "iam_user_with_buillt_in_duo_mfa" {
  title       = "Snowflake recommends always using MFA as it provides an additional layer of security for user access."
  description = "Built-in Duo MFA: Snowflake offers a built-in MFA powered by Duo Security. Use it only when you are not integrating with an Identity Provider."
  # docs = ""
  sql = <<EOT
    select
      name as resource,
      case
        when ext_authn_duo then 'ok'
        else 'alarm'
      end as status,
      case
        when ext_authn_duo then name || ' has Built-in Duo MFA.'
        else name || ' does not have Built-in Duo MFA.'
      end as reason
    from
      snowflake_user
    EOT
}

control "iam_user_default_role_is_set" {
  title       = "Snowflake recommends the default_role property for the user is set it to their functional role."
  description = "Snowflake recommends the default_role property for the user is set it to their functional role."
  # docs = ""
  sql = <<EOT
    select
      name as resource,
      case
        when default_role  = '' then 'alarm'
        else 'ok'
      end as status,
      case
        when default_role  = '' then name || ' default_role is not set.'
        else name || ' default_role is set.'
      end as reason
    from
      snowflake_user
    EOT
}
