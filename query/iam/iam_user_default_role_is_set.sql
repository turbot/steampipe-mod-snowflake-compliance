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

