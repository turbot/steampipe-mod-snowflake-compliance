select
  name as resource,
  case when ext_authn_duo then
    'ok'
  else
    'alarm'
  end as status,
  case when ext_authn_duo then
    name || ' has Built-in Duo MFA.'
  else
    name || ' does not have Built-in Duo MFA.'
  end as reason,
  account
from
  snowflake_user;

