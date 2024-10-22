query "network_policy_allowed_list_set" {
  sql = <<-EOQ
    with applied_network_policy as (
      select
        name,
        allowed_ip_list,
        account
      from
        snowflake_network_policy
      where
        name = (
          select
            value
          from
            snowflake_account_parameter
          where
            key = 'NETWORK_POLICY')
    ),
    analysis as (
      select
        name,
        to_jsonb ($1::text[]) <@ array_to_json(string_to_array(allowed_ip_list, ','))::jsonb as has_allowed_ips,
        to_jsonb ($1) - string_to_array(allowed_ip_list, ',', '') as missing_ips,
      account
    from
      applied_network_policy
    )
    select
      coalesce(analysis.name, sap.account) as resource,
      case when (
        select
          count(*)
        from
          applied_network_policy
        group by
          name) is null then
        'alarm'
      when has_allowed_ips then
        'ok'
      else
        'alarm'
      end as status,
      case when (
        select
          count(*)
        from
          applied_network_policy
        group by
          name) is null then
        'No network policy activated in the account.'
      when has_allowed_ips then
        name || ' has all allowed IPs.'
      else
        name || ' is missing allowed IPs: ' || array_to_string(array (
            select
              jsonb_array_elements_text(missing_ips)), ', ') || '.'
      end as reason,
      sap.account
    from
      snowflake_account_parameter as sap
      left join analysis on sap.account = analysis.account
    where
      key = 'NETWORK_POLICY';
  EOQ
}

query "network_policy_blocked_list_set" {
  sql = <<-EOQ
    with applied_network_policy as (
      select
        name,
        coalesce(blocked_ip_list, '') as blocked_ip_list, -- blocked_ip_list is optional therefore can be null
        account
      from
        snowflake_network_policy
      where
        name = (
          select
            value
          from
            snowflake_account_parameter
          where
            key = 'NETWORK_POLICY')
    ),
    analysis as (
      select
        name,
        to_jsonb ($1::text[]) <@ array_to_json(string_to_array(blocked_ip_list, ','))::jsonb as has_blocked_ips,
        to_jsonb ($1) - string_to_array(blocked_ip_list, ',', '') as missing_ips,
        account
      from
        applied_network_policy
    )
    select
      coalesce(analysis.name, sap.account) as resource,
      case when (
        select
          count(*)
        from
          applied_network_policy
        group by
          name) is null then
        'alarm'
      when has_blocked_ips then
        'ok'
      else
        'alarm'
      end as status,
      case when (
        select
          count(*)
        from
          applied_network_policy
        group by
          name) is null then
        'No network policy activated in the account.'
      when has_blocked_ips then
        name || ' has all blocked IPs.'
      else
        name || ' is missing blocked IPs: ' || array_to_string(array (
            select
              jsonb_array_elements_text(missing_ips)), ', ') || '.'
      end as reason,
      sap.account
    from
      snowflake_account_parameter as sap
      left join analysis on sap.account = analysis.account
    where
      key = 'NETWORK_POLICY';
  EOQ
}