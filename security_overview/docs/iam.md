## Identity and Access Management

Once your Snowflake account is accessible, the next step in gaining access to Snowflake is to authenticate the user. Users must be created in Snowflake prior to any access. Once the user is authenticated, a session is created with roles used to authorize access in Snowflake.

This section covers best practices for:

1. Managing users and roles
2. Authentication and single sign-on
3. Sessions
4. Object-level access control (authorization)
5. Column-level access control
6. Row-level access control

### Managing users and roles

Snowflake recommends using SCIM where supported by your Identity Provider to provision and externally manage users and roles in Snowflake. Identity Providers can be further configured to synchronize users and roles with your Active Directory users and groups. Review the Okta SCIM and Azure AD SCIM FAQs before integrating with these providers. If you can’t use SCIM for any reason, then build your own AD sync tool similar to this one using a Snowflake driver.

### Authentication best practices

Snowflake recommends creating a spreadsheet listing all the client applications connecting to Snowflake and their authentication capabilities. If the app supports multiple authentication methods, then use the method in the below priority order.

**Preference #1:** OAuth (either Snowflake OAuth or External OAuth)

**Preference #2:** External Browser, if it's a desktop application that doesn’t support OAuth

**Preference #3:** Okta native authentication, if you’re using Okta, and the app supports this method while not supporting OAuth or external browser authentication yet.

**Preference #4:** Key Pair Authentication, mostly used for service account users. Since this requires the client application to manage private keys, complement it with your internal key management software.

**Preference #5:** Password, this should be the last option for applications that don’t support any of the above options. This option is commonly used for service account users connecting from 3rd party ETL apps.

#### Multi-factor authentication (MFA)

Snowflake recommends always using MFA as it provides an additional layer of security for user access. There are two ways to enable it for your Snowflake account.

- Enable it in your identity provider: Users are prompted for MFA when Snowflake redirects the user to the identity provider for authentication. This is a preferred mechanism to use MFA as it allows you to bring your own (BYO) MFA. It works with SAML, OAuth, and External Browser authentication. Additionally, it provides ease of use for end-users as they need to have a single MFA application to manage for accessing Snowflake and other company resources.
- Built-in Duo MFA: Snowflake offers a built-in MFA powered by Duo Security. Use it only when you are not integrating with an Identity Provider.

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
