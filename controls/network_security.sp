variable "mandatory_ips" {
  type        = list(string)
  description = "A list of IPs allowed in Snowflake network policies."
}

benchmark "network_security" {
  title       = "Network Security Best Practices"
  description = "Network security or isolation provides the first line of defense for your Snowflake account."
  children = [
    control.network_security_use_network_policies,
    control.network_security_use_private_connectivity,
    control.network_security_allow_firewall_to_connect_client_applications,
    control.network_security_add_snowflake_ip_to_your_storage_policy_firewall_rules,
  ]
}

control "network_security_use_network_policies" {
  title       = "Use network policies to allow “known” client locations (IP ranges)"
  description = "The network policy restricts the list of user IP addresses when exchanging an authorization code for an access or refresh token and when using a refresh token to obtain a new access token."
  sql         = query.use_network_policies.sql
  param "mandatory_ips" {
    default = var.mandatory_ips
  }
}

control "network_security_use_private_connectivity" {
  title       = "Use private connectivity with Snowflake"
  description = "Use private connectivity with Snowflake by connecting to Snowflake over a private IP address using cloud service providers' private connectivity such as AWS PrivateLink or Azure Private Link."
  sql         = query.manual_control.sql
}

control "network_security_allow_firewall_to_connect_client_applications" {
  title       = "Allow firewall to connect client applications to Snowflake"
  description = "Allow firewall to connect client applications to Snowflake if your network has a firewall for egress traffic."
  sql         = query.manual_control.sql
}

control "network_security_add_snowflake_ip_to_your_storage_policy_firewall_rules" {
  title       = "Allow Snowflake to access your cloud storage location"
  description = "Allow Snowflake to access your cloud storage location for bulk loading/unloading data using COPY by adding Snowflake VPC id for AWS and/or VNet Subnet ids for Azure to your storage policy or firewall rules."
  sql         = query.manual_control.sql
}
