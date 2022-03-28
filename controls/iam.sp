#   sql           = query.manual_control.sql

benchmark "iam_best_practices" {
  title       = "Identity and Access Management Best Practices"
  description = "Once your Snowflake account is accessible, the next step in gaining access to Snowflake is to authenticate the user. Users must be created in Snowflake prior to any access. Once the user is authenticated, a session is created with roles used to authorize access in Snowflake. \nThis section covers best practices for: \n- Managing users and roles\n- Authentication and single sign-on\n- Sessions\n- Object-level access control (authorization)\n- Column-level access control\n- Row-level access control"
  children = [
    control.iam_user_has_password,
    control.iam_user_with_buillt_in_duo_mfa,
    control.iam_user_default_role_is_set,
    control.iam_schema_managed_access_to_centralize_grant_management,
    benchmark.iam_designating_additional_users_as_account_administrators
  ]
}

# Shall we restrict such queries by no of days we are looking for
control "iam_user_has_password" {
  title       = "For users who don't require a password in Snowflake, set the password property to null."
  description = "For users who don't require a password in Snowflake, set the password property to null. This will ensure that the password as an authentication method isn't available to those users, and they can't set the password themselves."
  sql         = <<EOT
    select
      name as resource,
      case
        when has_password then 'alarm'
        else 'ok'
      end as status,
      case
        when has_password then name || ' has password set.'
        else name || ' does not have password set.'
      end as reason,
      account
    from
      snowflake_user
    EOT
}

control "iam_user_with_buillt_in_duo_mfa" {
  title       = "Snowflake recommends always using MFA as it provides an additional layer of security for user access."
  description = "Built-in Duo MFA: Snowflake offers a built-in MFA powered by Duo Security. Use it only when you are not integrating with an Identity Provider."
  sql         = <<EOT
    select
      name as resource,
      case
        when ext_authn_duo then 'ok'
        else 'alarm'
      end as status,
      case
        when ext_authn_duo then name || ' has Built-in Duo MFA.'
        else name || ' does not have Built-in Duo MFA.'
      end as reason,
      account
    from
      snowflake_user
    EOT
}

control "iam_user_default_role_is_set" {
  title       = "Snowflake recommends the default_role property for the user is set it to their functional role."
  description = "Snowflake recommends the default_role property for the user is set it to their functional role."
  sql         = <<EOT
    select
      name as resource,
      case
        when default_role  = '' then 'alarm'
        else 'ok'
      end as status,
      case
        when default_role  = '' then name || ' default_role is not set.'
        else name || ' default_role is set.'
      end as reason,
      account
    from
      snowflake_user
    EOT
}

# Use managed access schema to centralize grant management
control "iam_schema_managed_access_to_centralize_grant_management" {
  title       = "Centralizing Grant Management Using Managed Access Schemas"
  description = "Managed access schemas improve security by locking down privilege management on objects. In regular (i.e. non-managed) schemas, object owners (i.e. a role with the OWNERSHIP privilege on an object) can grant access on their objects to other roles, with the option to further grant those roles the ability to manage object grants. With managed access schemas, object owners lose the ability to make grant decisions. Only the schema owner (i.e. the role with the OWNERSHIP privilege on the schema) or a role with the MANAGE GRANTS privilege can grant privileges on objects in the schema, including future grants, centralizing privilege management."
  sql         = <<EOT
    select
      catalog_name || '.' || schema_name as resource,
      case
        when is_managed_access  = 'NO' then 'alarm'
        else 'ok'
      end as status,
      case
        when is_managed_access  = 'NO' then catalog_name || '.' || schema_name || ' schema managed access is not set.'
        else  catalog_name || '.' || schema_name || ' schema managed access is set.'
      end as reason,
      account
    from
      snowflake_schemata
    EOT
}

# Use managed access schema to centralize grant management
benchmark "iam_designating_additional_users_as_account_administrators" {
  title       = "Designating Additional Users as Account Administrators"
  description = "By default, each account has one user who has been designated as an account administrator (i.e. user granted the system-defined ACCOUNTADMIN role). Snowflake recommend designating at least one other user as an account administrator. This helps ensure that your account always has at least one user who can perform account-level tasks, particularly if one of your account administrators is unable to log in."
  children = [
    control.iam_user_accountadmin_role_grants,
    control.iam_user_accountadmin_role_must_not_be_default_role,
    control.iam_user_with_accountadmin_role_have_email
  ]
}

# Use managed access schema to centralize grant management
control "iam_user_accountadmin_role_grants" {
  title       = "ACCOUNTADMIN admin role must not be granted to more than 2 Users"
  description = "By default, each account has one user who has been designated as an account administrator (i.e. user granted the system-defined ACCOUNTADMIN role). We recommend designating at least one other user as an account administrator. This helps ensure that your account always has at least one user who can perform account-level tasks, particularly if one of your account administrators is unable to log in."
  sql         = <<EOT
    with users_with_account_admin_role as
    (
      select
        role,
        granted_to,
        grantee_name,
        granted_by,
        created_on,
        account
      from
        snowflake_role_grant
      where
        role = 'ACCOUNTADMIN'
        and granted_to = 'USER'
    )
    select
      account as resource,
      case
        when count(grantee_name) = 2 then 'ok'
        else 'alarm'
      end as status,
      case
        when count(grantee_name) < 2 then 'ACCOUNTADMIN role is granted to less than 2 users.'
        when count(grantee_name) > 2 then 'ACCOUNTADMIN role is granted to more than 2 users.'
        else 'ACCOUNTADMIN role is granted to two users.'
      end as reason,
      account
    from
      users_with_account_admin_role
    group by account
    EOT
}

control "iam_user_accountadmin_role_must_not_be_default_role" {
  title       = "ACCOUNTADMIN admin role must not set as the default role."
  description = "Grant the ACCOUNTADMIN role to the user(s), but do not set this role as their default. Instead, designate a lower-level administrative role (e.g. SYSADMIN) or custom role as their default. This helps prevent account administrators from inadvertently using the ACCOUNTADMIN role to create objects."
  sql         = <<EOT
    select
      name as resource,
      case
        when default_role = 'ACCOUNTADMIN' then 'alarm'
        else 'ok'
      end as status,
      case
        when default_role = 'ACCOUNTADMIN' then 'ACCOUNTADMIN is default_role for user ' || name
        else 'ACCOUNTADMIN role is not default_role for user ' || name
      end as reason,
      account
    from
      snowflake_user
    EOT
}

control "iam_user_with_accountadmin_role_have_email" {
  title       = "Ensure an email address is specified for each user with ACCOUNTADMIN role."
  description = "Snowflake recommendsto associate an actual person's email address to ACCOUNTADMIN users, so that Snowflake Support knows who to contact in an urgent situation."
  sql         = <<EOT
    with users_with_account_admin_role as
    (
      select
        role,
        granted_to,
        grantee_name,
        granted_by,
        created_on
      from
        snowflake_role_grant
      where
        role = 'ACCOUNTADMIN'
        and granted_to = 'USER'
    )
    select
      name as resource,
      case
        when email != '' then 'ok'
        else 'alarm'
      end as status,
      case
        when email != ''
        then name || ' have email address set.'
        else name || ' does not have email address set.'
      end as reason,
      su.account
    from
      snowflake_user as su
      inner join
        users_with_account_admin_role as sua
        on su.name = sua.grantee_name
    EOT
}
