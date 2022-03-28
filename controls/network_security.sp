variable "mandatory_ips" {
  type        = list(string)
  description = "A list of IPs allowed in network policies."
}

benchmark "network_security" {
  title       = "Network Security"
  description = "Network security or isolation provides the first line of defense."
  children = [
    control.use_network_policies,
    control.use_private_connectivity,
    control.allow_firewall_to_connect_client_applications,
    control.add_snowflake_ip_to_your_storage_policy_firewall_rules,
  ]
}

control "use_network_policies" {
  title       = "Use network policies to allow “known” client locations (IP ranges) to connect to your Snowflake account while blocking others."
  description = "The network policy restricts the list of user IP addresses when exchanging an authorization code for an access or refresh token and when using a refresh token to obtain a new access token."
  sql         = <<EOT
    with analysis as (
      select
        name,
        to_jsonb($1::text[]) <@ array_to_json(string_to_array(allowed_ip_list, ','))::jsonb as has_mandatory_ips,
        to_jsonb($1) - string_to_array(allowed_ip_list, ',', '') as missing_ips,
        account
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
      end as reason,
      account
    from
      analysis
    EOT
  param "mandatory_ips" {
    default = var.mandatory_ips
  }
}

control "use_private_connectivity" {
  title       = "Use private connectivity with Snowflake."
  description = "Use private connectivity with Snowflake by connecting to Snowflake over a private IP address using cloud service providers' private connectivity such as AWS PrivateLink or Azure Private Link."
  sql         = query.manual_control.sql
}

control "allow_firewall_to_connect_client_applications" {
  title       = "Allow firewall to connect client applications to Snowflake."
  description = "Allow firewall to connect client applications to Snowflake if your network has a firewall for egress traffic."
  sql         = query.manual_control.sql
}

control "add_snowflake_ip_to_your_storage_policy_firewall_rules" {
  title       = "Allow Snowflake to access your cloud storage location."
  description = "Allow Snowflake to access your cloud storage location for bulk loading/unloading data using COPY by adding Snowflake VPC id for AWS and/or VNet Subnet ids for Azure to your storage policy or firewall rules."
  sql         = query.manual_control.sql
}
