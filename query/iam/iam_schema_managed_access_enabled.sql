select
  catalog_name || '.' || schema_name as resource,
  case when is_managed_access = 'NO' then
    'alarm'
  else
    'ok'
  end as status,
  case when is_managed_access = 'NO' then
    catalog_name || '.' || schema_name || ' schema managed access is not set.'
  else
    catalog_name || '.' || schema_name || ' schema managed access is set.'
  end as reason,
  account
from
  snowflake_schemata;
