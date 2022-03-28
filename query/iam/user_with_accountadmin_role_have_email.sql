with users_with_account_admin_role as (
  select
    role,
    granted_to,
    grantee_name,
    granted_by
  from
    snowflake_role_grant
  where
    role = 'ACCOUNTADMIN'
    and granted_to = 'USER'
)
select
  name as resource,
  case when email != '' then
    'ok'
  else
    'alarm'
  end as status,
  case when email != '' then
    name || ' email address set.'
  else
    name || ' email address not set.'
  end as reason,
  su.account
from
  snowflake_user as su
  inner join users_with_account_admin_role as sua on su.name = sua.grantee_name;
