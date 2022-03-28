select
  -- Required Columns
  account as resource,
  'info' as status,
  'Manual verification required.' as reason,
  -- Additional Dimensions
  account
from
  snowflake_user
limit 1;

