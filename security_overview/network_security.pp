variable "allowed_ips" {
  type        = list(string)
  default     = ["192.168.1.0/24"]
  description = "A list of IPs allowed in Snowflake network policies."
}

variable "blocked_ips" {
  type        = list(string)
  default     = ["192.168.1.99"]
  description = "A list of IPs that are denied access in Snowflake network policies."
}

benchmark "security_overview_network_security" {
  title         = "Network Security"
  description   = "Network security or isolation provides the first line of defense for Snowflake account."
  documentation = file("./security_overview/docs/network_security.md")
  children = [
    control.security_overview_network_security_network_policy_allowed_list_set,
    control.security_overview_network_security_network_policy_blocked_list_set,
    control.security_overview_network_security_use_private_connectivity,
    control.security_overview_network_security_allow_firewall_to_connect_client_applications,
    control.security_overview_network_security_add_snowflake_ip_policy_firewall_rules,
  ]

  tags = merge(local.security_overview_common_tags, {
    type = "Benchmark"
  })
}

control "security_overview_network_security_network_policy_allowed_list_set" {
  title         = "Use network policies to allow 'known' client locations (IP ranges)"
  description   = "The network policy restricts the list of user IP addresses when exchanging an authorization code for an access or refresh token and when using a refresh token to obtain a new access token."
  documentation = file("./security_overview/docs/network_security_network_policy_allowed_list_set.md")
  query         = query.network_policy_allowed_list_set

  param "allowed_ips" {
    default = var.allowed_ips
  }
}

control "security_overview_network_security_network_policy_blocked_list_set" {
  title         = "Use network policies blocked list to deny access to specific list of IPv4 addresses"
  description   = "The network policy restricts the list of user IP addresses when exchanging an authorization code for an access or refresh token and when using a refresh token to obtain a new access token."
  documentation = file("./security_overview/docs/network_security_network_policy_blocked_list_set.md")
  query         = query.network_policy_blocked_list_set

  param "blocked_ips" {
    default = var.blocked_ips
  }
}

control "security_overview_network_security_use_private_connectivity" {
  title         = "Use private connectivity with Snowflake"
  description   = "Use private connectivity with Snowflake by connecting to Snowflake over a private IP address using cloud service providers' private connectivity such as AWS PrivateLink or Azure Private Link."
  documentation = file("./security_overview/docs/network_security_use_private_connectivity.md")
  query         = query.manual_control
}

control "security_overview_network_security_allow_firewall_to_connect_client_applications" {
  title         = "Allow firewall to connect client applications to Snowflake"
  description   = "Allow firewall to connect client applications to Snowflake if your network has a firewall for egress traffic."
  documentation = file("./security_overview/docs/network_security_allow_firewall_to_connect_client_applications.md")
  query         = query.manual_control
}

control "security_overview_network_security_add_snowflake_ip_policy_firewall_rules" {
  title         = "Allow Snowflake to access your cloud storage location"
  description   = "Allow Snowflake to access your cloud storage location for bulk loading/unloading data using COPY by adding Snowflake VPC id for AWS and/or VNet Subnet ids for Azure to your storage policy or firewall rules."
  documentation = file("./security_overview/docs/network_security_add_snowflake_ip_policy_firewall_rules.md")
  query         = query.manual_control
}
