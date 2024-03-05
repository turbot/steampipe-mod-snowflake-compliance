benchmark "security_overview_iam" {
  title         = "Identity and Access Management"
  description   = "Snowflake IAM best practises."
  documentation = file("./security_overview/docs/iam.md")
  children = [
    control.security_overview_iam_user_without_accountadmin_role_password_not_set,
    control.security_overview_iam_user_with_built_in_duo_mfa_enabled,
    control.security_overview_iam_user_default_role_is_set,
    control.security_overview_iam_schema_managed_access,
    control.security_overview_iam_two_users_accountadmin_role,
    control.security_overview_iam_user_accountadmin_must_not_be_default_role,
    control.security_overview_iam_user_with_accountadmin_role_have_email
  ]

  tags = merge(local.security_overview_common_tags, {
    type = "Benchmark"
  })
}

# https://docs.snowflake.com/en/user-guide/admin-security-fed-auth-use.html#managing-users-with-federated-authentication-enabled
control "security_overview_iam_user_without_accountadmin_role_password_not_set" {
  title         = "Disable Snowflake authentication for all non-administrator users"
  description   = "For users who don't require a password in Snowflake, set the password property to null. This will ensure that the password as an authentication method isn't available to those users, and they can't set the password themselves."
  documentation = file("./security_overview/docs/iam_user_without_accountadmin_role_password_is_not_set.md")
  query         = query.iam_user_without_accountadmin_role_password_not_set
}

control "security_overview_iam_user_with_built_in_duo_mfa_enabled" {
  title         = "Enable MFA for users to provide an additional layer of security"
  description   = "Snowflake supports multi-factor authentication (i.e. MFA) to provide increased login security for users connecting to Snowflake. MFA support is provided as an integrated Snowflake feature, powered by the Duo Securityservice, which is managed completely by Snowflake."
  documentation = file("./security_overview/docs/iam_user_built_in_duo_mfa_enabled.md")
  query         = query.iam_user_with_built_in_duo_mfa_enabled
}

control "security_overview_iam_user_default_role_is_set" {
  title       = "Set the default_role property for users"
  description = "A user's default role determines the role used in the Snowflake sessions initiated by the user; however, this is only a default. Users can change roles within a session at any time. Snowflake recommends that designate a lower-level administrative or custom role as their default."
  query       = query.iam_user_default_role_is_set
}

# https://docs.snowflake.com/en/user-guide/security-access-control-considerations.html#centralizing-grant-management-using-managed-access-schemas
control "security_overview_iam_schema_managed_access" {
  title         = "Use managed access schemas to centralize grant management"
  description   = "Managed access schemas improve security by locking down privilege management on objects. In regular (i.e. non-managed) schemas, object owners (i.e. a role with the OWNERSHIP privilege on an object) can grant access on their objects to other roles, with the option to further grant those roles the ability to manage object grants. With managed access schemas, object owners lose the ability to make grant decisions. Only the schema owner (i.e. the role with the OWNERSHIP privilege on the schema) or a role with the MANAGE GRANTS privilege can grant privileges on objects in the schema, including future grants, centralizing privilege management."
  documentation = file("./security_overview/docs/iam_schema_managed_access_enabled.md")
  query         = query.iam_schema_managed_access_enabled
}

# https://docs.snowflake.com/en/user-guide/admin-user-management.html
control "security_overview_iam_two_users_accountadmin_role" {
  title       = "At least two users must be assigned ACCOUNTADMIN role"
  description = "By default, each account has one user who has been designated as an account administrator (i.e. user granted the system-defined ACCOUNTADMIN role). Snowflake recommend designating at least one other user as an account administrator. This helps ensure that your account always has at least one user who can perform account-level tasks, particularly if one of your account administrators is unable to log in."
  query       = query.iam_user_at_least_two_users_with_accountadmin_role
}

control "security_overview_iam_user_accountadmin_must_not_be_default_role" {
  title       = "ACCOUNTADMIN role must not be set as the default role for users"
  description = "Grant the ACCOUNTADMIN role to the user(s), but do not set this role as their default. Instead, designate a lower-level administrative role (e.g. SYSADMIN) or custom role as their default. This helps prevent account administrators from inadvertently using the ACCOUNTADMIN role to create objects."
  query       = query.iam_user_default_role_must_not_be_accountadmin
}

control "security_overview_iam_user_with_accountadmin_role_have_email" {
  title       = "Ensure an email address is specified for users with ACCOUNTADMIN role"
  description = "Snowflake recommendsto associate an actual person's email address to ACCOUNTADMIN users, so that Snowflake Support knows who to contact in an urgent situation."
  query       = query.iam_user_with_accountadmin_role_have_email
}
