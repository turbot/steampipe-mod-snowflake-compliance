## Description

Use private connectivity with Snowflake by connecting to Snowflake over a private IP address using cloud service providers' private connectivity such as [AWS PrivateLink](https://docs.snowflake.com/en/user-guide/admin-security-privatelink.html) or [Azure Private Link](https://docs.snowflake.com/en/user-guide/privatelink-azure.html). With this feature, your Snowflake account appears as a resource in your network. Here’re a few best practices to consider when using this feature.

- You’re responsible for setting up DNS to resolve Snowflake's private URL. Using private DNS in your cloud provider network is the best practice as it allows Snowflake account to be resolved from clients running both in the cloud provider network and on-premises. You can then create a DNS forwarding rule for the Snowflake account in your on-premise DNS.

- After you’ve configured private connectivity, if you want to block access to the public endpoint, then you can create an account level network policy allowing only your network’s private IP range to connect into Snowflake.

- If you want to allow client applications running outside your network to connect into Snowflake, then they would be connecting to your account over a public endpoint. To allow access, based on the use case, you can add the client application’s IP range to the allowed list of account level, user level, or OAuth integration network policy.
