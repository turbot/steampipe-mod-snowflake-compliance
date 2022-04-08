select
  name as resource,
  case
    when name = 'SNOWFLAKE' then 'skip'
    when not has_password then 'skip'
    when now()::date - password_last_set_time::date > $1::int then 'alarm'
    else 'ok'
  end as status,
  case
    when name = 'SNOWFLAKE' then name || ' is a Snowflake Support user.'
    when not has_password then name || ' password not set.'
    else name || ' password rotated ' || (now()::date - password_last_set_time::date) || ' days ago.'
  end as reason,
  account
from
  snowflake_user;
