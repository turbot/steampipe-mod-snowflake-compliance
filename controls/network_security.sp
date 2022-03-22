variable "mandatory_ips" {
  type        = list(string)
  description = "A list of IPs allowed in network policies."
}

benchmark "network_security" {
  title       = "Network Security"
  description = "Network security or isolation provides the first line of defense."
  # documentation = file("./cis_v140/docs/cis_overview.md")
  children = [
    control.use_network_policies,
  ]
}

control "use_network_policies" {
  title       = "Use network policies to allow “known” client locations (IP ranges) to connect to your Snowflake account while blocking others."
  description = "The network policy restricts the list of user IP addresses when exchanging an authorization code for an access or refresh token and when using a refresh token to obtain a new access token."
  # docs = ""
  sql = <<EOT
    with analysis as (
      select
        name,
        to_jsonb($1::text[]) <@ array_to_json(string_to_array(allowed_ip_list, ','))::jsonb as has_mandatory_ips,
        to_jsonb($1) - string_to_array(allowed_ip_list, ',', '') as missing_ips
      from
        snowflake_network_policy
    )
    select
      name as resource,
      case
        when has_mandatory_ips then 'ok'
        else 'alarm'
      end as status,
      case
        when has_mandatory_ips then name || ' has all mandatory ips.'
        else name || ' is missing ips: ' || array_to_string(array(select jsonb_array_elements_text(missing_ips)), ', ') || '.'
      end as reason
    from
      analysis
    EOT
  param "mandatory_ips" {
    default = var.mandatory_ips
  }
}


