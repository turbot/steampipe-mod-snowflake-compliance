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
