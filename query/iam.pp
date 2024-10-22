query "iam_schema_managed_access_enabled" {
  sql = <<-EOQ
    select
      catalog_name || '.' || schema_name as resource,
      case when is_managed_access = 'NO' then
        'alarm'
      else
        'ok'
      end as status,
      case when is_managed_access = 'NO' then
        catalog_name || '.' || schema_name || ' schema managed access is not set.'
      else
        catalog_name || '.' || schema_name || ' schema managed access is set.'
      end as reason,
      account
    from
      snowflake_schemata;
  EOQ
}

query "iam_user_at_least_two_users_with_accountadmin_role" {
  sql = <<-EOQ
    with users_with_account_admin_role as (
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
      case when count(grantee_name) > 1 then
        'ok'
      else
        'alarm'
      end as status,
      'ACCOUNTADMIN role is granted to ' || count(grantee_name) || ' user(s).' as reason,
      account
    from
      users_with_account_admin_role
    group by
      account;
  EOQ
}

query "iam_user_default_role_is_set" {
  sql = <<-EOQ
    select
      name as resource,
      case when default_role = '' then
        'alarm'
      else
        'ok'
      end as status,
      case when default_role = '' then
        name || ' default_role is not set.'
      else
        name || ' default_role is set.'
      end as reason,
      account
    from
      snowflake_user;
  EOQ
}

query "iam_user_default_role_must_not_be_accountadmin" {
  sql = <<-EOQ
    select
      name as resource,
      case when default_role = 'ACCOUNTADMIN' then
        'alarm'
      else
        'ok'
      end as status,
      name || ' default_role is ' || default_role || '.' as reason,
      account
    from
      snowflake_user;
  EOQ
}

query "iam_user_with_accountadmin_role_have_email" {
  sql = <<-EOQ
    with users_with_account_admin_role as (
      select
        grantee_name
      from
        snowflake_role_grant
      where
        role = 'ACCOUNTADMIN'
        and granted_to = 'USER'
    )
    select
      name as resource,
      case
        when name not in (select * from users_with_account_admin_role) then 'skip'
        when email != '' then 'ok'
        else 'alarm'
      end as status,
      case
        when name not in (select * from users_with_account_admin_role) then name || ' does not have ACCOUNTADMIN role.'
        when email != '' then name || ' email address set.'
        else name || ' email address not set.'
      end as reason,
      account
    from
      snowflake_user;
  EOQ
}

query "iam_user_with_built_in_duo_mfa_enabled" {
  sql = <<-EOQ
    select
      name as resource,
      case when ext_authn_duo then
        'ok'
      else
        'alarm'
      end as status,
      case when ext_authn_duo then
        name || ' built-in Duo MFA enabled.'
      else
        name || ' built-in Duo MFA not enabled.'
      end as reason,
      account
    from
      snowflake_user;
  EOQ
}

query "iam_user_without_accountadmin_role_password_not_set" {
  sql = <<-EOQ
    with users_with_account_admin_role as (
      select
        grantee_name
      from
        snowflake_role_grant
      where
        role = 'ACCOUNTADMIN'
        and granted_to = 'USER'
    )
    select
      name as resource,
      case
        when name in (select * from users_with_account_admin_role) then 'skip'
        when has_password then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select * from users_with_account_admin_role) then name || ' has ACCOUNTADMIN role.'
        when has_password then name || ' has password set.'
        else name || ' does not have password set.'
      end as reason,
      account
    from
      snowflake_user;
  EOQ
}