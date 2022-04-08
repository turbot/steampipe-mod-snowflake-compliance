benchmark "security_overview_data_encryption" {
  title         = "Data Encryption"
  description   = "All data stored in Snowflake is transparently encrypted using a key hierarchy (with cloud HSM backed root of trust), which provides enhanced security by encrypting individual pieces of data using a different key."
  documentation = file("./security_overview/docs/data_encryption.md")
  children = [
    control.security_overview_data_encryption_use_tri_secret_secure,
    control.security_overview_data_encryption_automatic_cmk_rotation,
    control.security_overview_data_encryption_tri_secret_secure_in_database_replication,
    control.security_overview_data_encryption_enable_periodic_rekeying,
    control.security_overview_data_encryption_use_built_in_encryption_functions,
  ]
}

control "security_overview_data_encryption_use_tri_secret_secure" {
  title         = "Use Tri-Secret Secure"
  description   = "Tri-Secret Secure is the combination of a Snowflake-maintained key and a customer-managed key in the cloud provider platform that hosts your Snowflake account to create a composite master key to protect your Snowflake data. The composite master key acts as an account master key and wraps all of the keys in the hierarchy."
  documentation = file("./security_overview/docs/data_encryption_use_tri_secret_secure.md")
  sql           = query.manual_control.sql
}
control "security_overview_data_encryption_automatic_cmk_rotation" {
  title       = "Use automatic key rotation for the CMK as provided by the cloud provider"
  description = "Use automatic key rotation for the CMK as provided by the cloud provider (such as AWS KMS)."
  sql         = query.manual_control.sql
}
control "security_overview_data_encryption_tri_secret_secure_in_database_replication" {
  title         = "Enable Tri-Secret Secure in the target account when using the database Replication"
  description   = "Enable Tri-Secret Secure in the target account when using the Replication feature to replicate a database to another account."
  documentation = file("./security_overview/docs/data_encryption_tri_secret_secure_in_database_replication.md")
  sql           = query.manual_control.sql
}
control "security_overview_data_encryption_enable_periodic_rekeying" {
  title         = "Enable periodic rekeying in Snowflake"
  description   = "Enable periodic rekeying in Snowflake if your organization requires rekeying of data at regular intervals."
  documentation = file("./security_overview/docs/data_encryption_enable_periodic_rekeying.md")
  sql           = query.manual_control.sql
}

control "security_overview_data_encryption_use_built_in_encryption_functions" {
  title         = "Use built-in encryption functions in addition to the transparent encryption to encrypt/decrypt certain columns"
  description   = "To encrypt/decrypt certain columns in addition to the transparent encryption provided by Snowflake, use the built-in encryption functions."
  documentation = file("./security_overview/docs/data_encryption_use_built_in_encryption_functions.md")
  sql           = query.manual_control.sql
}
