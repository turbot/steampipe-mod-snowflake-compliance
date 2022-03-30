## Description

With federated authentication enabled for an account, Snowflake still allows maintaining and using Snowflake user credentials (login name and password). In other words:

- Account and security administrators can still create users with passwords maintained in Snowflake.

- Users can still log into Snowflake using their Snowflake credentials.

However, if federated authentication is enabled for account, Snowflake does **not** recommend maintaining user passwords in Snowflake. Instead, user passwords should be maintained solely in the IdP.

If a user with no password (or alter an existing user and remove their password), this effectively disables Snowflake authentication for the user. Without a password in Snowflake, a user cannot log in using Snowflake authentication and must use federated authentication instead.

Specifically, Snowflake recommends disabling Snowflake authentication for all non-administrator users.

### Sessions

Once the user is authenticated, Snowflake creates a database session for the user. The client application can then use the session to submit queries into Snowflake. Each session has a 4 hrs of idle (inactivity) timeout. Using a session, new child sessions can be created. For example, the Snowflake classic UI creates child sessions, one per worksheet. The session management best practices are as follows:

- Reuse sessions
- Close connection when no longer required
- Avoid using CLIENT_SESSION_KEEP_ALIVE
- Monitor session usage
- Reuse existing sessions from your client applications to receive the best performance, and avoid delays due to new session creation.

### Object-level Access Control

Roles are used for authorizing access to objects, such as tables, views, and functions, in Snowflake. Roles can contain other roles and have hierarchies. When a database session is created for a user, the primary role is associated with the session. All roles under the hierarchy of the primary role get activated in the session to perform the authorization. Take time to establish a proper role hierarchy model upfront.

Snowflake recommends following best practices for access control in addition to reviewing the access control considerations section of Snowflake documentation:

- Define functional roles and access roles
- Avoid granting access roles to other access roles
- Use future grants
- Set default_role property for the user
- Create a role per user for cross-database join use cases
- Use managed access schema to centralize grant management

### Column-level Access Control

If you want to restrict access to sensitive information present in certain columns such as PII, PHI, or financial data, then Snowflake recommends using the following data governance features that allow you to restrict column access for unauthorized users.

- **Dynamic Data Masking**: this is a built-in feature that can dynamically obfuscate column data based on who’s querying it.

- **External Tokenization**: integrates with partner solutions to detokenize data at query time for authorized users.

- **Secure Views**: you can hide the columns entirely from unauthorized users.

### Row-level Access Control

You may have tables with mixed data to restrict access to certain rows to only certain users. For example, you may want to restrict the visibility of rows based on the user’s country, such as US employees can only view US order data, while French employees can only view order data from France. To solve this problem, you can create secure views using the `CURRENT_ROLE()` or `CURRENT_USER()` context functions to dynamically filter rows for the user querying the view.
