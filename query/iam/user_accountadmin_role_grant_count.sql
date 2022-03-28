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

