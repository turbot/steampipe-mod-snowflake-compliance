## Description

Allow firewall to connect client applications to Snowflake if your network has a firewall for egress traffic.

- Run [SYSTEM\$WHITELIST](https://docs.snowflake.com/en/sql-reference/functions/system_whitelist.html) and/or [SYSTEM\$WHITELIST_PRIVATELINK](https://docs.snowflake.com/en/sql-reference/functions/system_whitelist_privatelink.html) based on whether you’re allowing public endpoint, the private endpoint, or both to be accessible for your Snowflake account.

- Use [SnowCD](https://docs.snowflake.com/en/user-guide/snowcd.html) to ensure proper connectivity has been set up with Snowflake.

- If you’re using network proxy to inspect egress traffic, then set it up for SSL passthrough. Snowflake doesn’t support SSL terminating proxies.
