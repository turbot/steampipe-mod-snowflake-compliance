## Network Security

Network security or isolation provides the first line of defense. The network security best practices are as follows:

- Use network policies
- Use private connectivity with Snowflake
- Allow firewall to connect client applications to Snowflake
- Allow Snowflake to access your cloud storage location for loading/unloading data

### Use network policies

Use network policies to allow “known” client locations (IP ranges) to connect to your Snowflake account while blocking others. Additionally, if you’re using service account users to connect from a client application, SCIM, or Snowflake OAuth integrations, check if you need to configure different network policies (SCIM network policy, OAuth network policy) that overrides the account level network policy.

### Use private connectivity with Snowflake

Use private connectivity with Snowflake by connecting to Snowflake over a private IP address using cloud service providers' private connectivity such as `AWS PrivateLink` or `Azure Private Link`. With this feature, your Snowflake account appears as a resource in your network.

### Allow firewall to connect client applications to Snowflake

Allow firewall to connect client applications to Snowflake if your network has a firewall for egress traffic.

- Run `SYSTEM$WHITELIST` and/or `SYSTEM$WHITELIST_PRIVATELINK` based on whether you’re allowing public endpoint, the private endpoint, or both to be accessible for your Snowflake account.

- Use `SnowCD` to ensure proper connectivity has been set up with Snowflake.

- If you’re using network proxy to inspect egress traffic, then set it up for SSL passthrough. Snowflake doesn’t support SSL terminating proxies.

### Allow Snowflake to access your cloud storage location for loading/unloading data

Allow Snowflake to access your cloud storage location for bulk loading/unloading data using COPY by adding Snowflake `VPC id for AWS` and/or `VNet Subnet ids for Azure` to your storage policy or firewall rules.
