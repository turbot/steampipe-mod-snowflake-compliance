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

