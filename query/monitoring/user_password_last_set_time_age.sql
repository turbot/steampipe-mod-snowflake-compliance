select
  name as resource,
  case when now()::date - password_last_set_time::date > $1::int then
    'alarm'
  else
    'ok'
  end as status,
  name || ' password was changed ' || (now()::date - password_last_set_time::date) || ' days ago.' as reason,
  account
from
  snowflake_user
where
  has_password
  and password_last_set_time is not null;

