## Description

Use network policies to allow `known` client locations (IP ranges) to connect to your Snowflake account while blocking others. Additionally, if you’re using service account users to connect from a client application, [SCIM](https://docs.snowflake.com/en/user-guide/scim.html), or Snowflake OAuth integrations, check if you need to configure different network policies (SCIM network policy, OAuth network policy) that overrides the account level network policy.
