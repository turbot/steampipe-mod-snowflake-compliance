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
  -- Required Columns
  name as resource,
  case
    when name not in (select * from users_with_account_admin_role) then 'skip'
    when has_password then 'alarm'
    else 'ok'
  end as status,
  case
    when name not in (select * from users_with_account_admin_role) then name || ' does not have ACCOUNTADMIN role.'
    when has_password then name || ' has password set.'
    else name || ' does not have password set.'
  end as reason,
  -- Additional columns
  account
from
  snowflake_user;

