To obtain the latest version of the official guide, please visit [SNOWFLAKE SECURITY OVERVIEW AND BEST PRACTICES](https://community.snowflake.com/s/article/Snowflake-Security-Overview-and-Best-Practices).

## Overview

The Snowflake security overview and best practices document provide an overview of security features and best practice guidelines for securing your data in Snowflake.

Snowflake secures customer data using defense in depth with three security layers.

- Network Security
- Identity and Access Management
- Data Encryption

### Monitoring

You can monitor the usage of Snowflake to meet your organization’s audit and compliance requirements.

Every Snowflake account comes with a system-defined, read-only shared database named `SNOWFLAKE`. It has a schema named `ACCOUNT_USAGE` containing views that provide access to one year of audit logs.
