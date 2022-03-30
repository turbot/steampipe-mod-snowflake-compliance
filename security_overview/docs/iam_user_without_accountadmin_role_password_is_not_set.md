## Description

With federated authentication enabled for an account, Snowflake still allows maintaining and using Snowflake user credentials (login name and password). In other words:

- Account and security administrators can still create users with passwords maintained in Snowflake.

- Users can still log into Snowflake using their Snowflake credentials.

However, if federated authentication is enabled for account, Snowflake does **not** recommend maintaining user passwords in Snowflake. Instead, user passwords should be maintained solely in the IdP.

If a user with no password (or alter an existing user and remove their password), this effectively disables Snowflake authentication for the user. Without a password in Snowflake, a user cannot log in using Snowflake authentication and must use federated authentication instead.

Specifically, Snowflake recommends disabling Snowflake authentication for all non-administrator users.
