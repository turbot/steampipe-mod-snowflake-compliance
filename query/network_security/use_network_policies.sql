with analysis as (
  select
    name,
    to_jsonb ($1::text[]) <@ array_to_json(string_to_array(allowed_ip_list, ','))::jsonb as has_allowed_ips,
    to_jsonb ($1) - string_to_array(allowed_ip_list, ',', '') as missing_ips,
    account
  from
    snowflake_network_policy
)
select
  name as resource,
  case when has_allowed_ips then
    'ok'
  else
    'alarm'
  end as status,
  case when has_allowed_ips then
    name || ' has all allowed IPs.'
  else
    name || ' is missing allowed IPs: ' || array_to_string(array (
        select
          jsonb_array_elements_text(missing_ips)), ', ') || '.'
  end as reason,
  account
from
  analysis;

