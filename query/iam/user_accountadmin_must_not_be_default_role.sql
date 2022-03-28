select
  name as resource,
  case when default_role = 'ACCOUNTADMIN' then
    'alarm'
  else
    'ok'
  end as status,
  case when default_role = 'ACCOUNTADMIN' then
    'ACCOUNTADMIN is default_role for user ' || name || '.'
  else
    'ACCOUNTADMIN role is not default_role for user ' || name || '.'
  end as reason,
  account
from
  snowflake_user;

