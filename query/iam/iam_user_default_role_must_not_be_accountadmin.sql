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
