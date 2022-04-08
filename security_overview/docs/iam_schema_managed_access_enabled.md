## Description

With regular (i.e. non-managed) schemas in a database, object owners (i.e. roles with the OWNERSHIP privilege on one or more objects) can grant access on those objects to other roles, with the option to further grant those roles the ability to manage object grants.

To further lock down object security, consider using managed access schemas. In a managed access schema, object owners lose the ability to make grant decisions. Only the schema owner (i.e. the role with the OWNERSHIP privilege on the schema) or a role with the MANAGE GRANTS privilege can grant privileges on objects in the schema, including future grants, centralizing privilege management.

Note that a role that holds the global MANAGE GRANTS privilege can grant additional privileges to the current (grantor) role.
