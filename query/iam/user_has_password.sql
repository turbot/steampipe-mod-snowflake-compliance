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
  -- TODO: Skip users without ACCOUNTADMIN role with specific reason
  case when has_password then
    'alarm'
  else
    'ok'
  end as status,
  case when has_password then
    name || ' has password set.'
  else
    name || ' does not have password set.'
  end as reason,
  account
from
  snowflake_user
where
  name not in (
    select
      *
    from
      users_with_account_admin_role);
