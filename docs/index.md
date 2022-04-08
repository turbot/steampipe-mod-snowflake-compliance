---
repository: "https://github.com/turbot/steampipe-mod-snowflake-compliance"
---

# Snowflake Compliance Mod

Run individual configuration, compliance and security controls or full compliance benchmarks for `Security Overview and Best Practices` across all your Snowflake accounts.

![image](https://raw.githubusercontent.com/turbot/steampipe-mod-snowflake-compliance/main/docs/images/snowflake_compliance_mod_output.png)

## References

[Snowflake](https://snowflake.com/) is a single, integrated platform delivered as-a-service. It features storage, compute, and global services layers that are physically separated but logically integrated. Data workloads scale independently from one another, making it an ideal platform for data warehousing, data lakes, data engineering, data science, modern data sharing, and developing data applications.

[Snowflake Security Overview and Best Practices](https://community.snowflake.com/s/article/Snowflake-Security-Overview-and-Best-Practices) provides an overview of security features and best practice guidelines for securing your data in Snowflake.

[Steampipe](https://steampipe.io) is an open source CLI to instantly query cloud APIs using SQL.

[Steampipe Mods](https://steampipe.io/docs/reference/mod-resources#mod) are collections of `named queries`, and codified `controls` that can be used to test current configuration of your cloud resources against a desired configuration.

## Documentation

- **[Benchmarks and controls →](https://hub.steampipe.io/mods/turbot/snowflake_compliance/controls)**
- **[Named queries →](https://hub.steampipe.io/mods/turbot/snowflake_compliance/queries)**

## Get started

Install the Snowflake plugin with [Steampipe](https://steampipe.io):

```shell
steampipe plugin install snowflake
```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-snowflake-compliance.git
cd steampipe-mod-snowflake-compliance
```

Run all benchmarks:

```shell
steampipe check all
```

Run a single benchmark:

```shell
steampipe check benchmark.security_overview
```

Run a specific control:

```shell
steampipe check control.security_overview_iam_user_default_role_is_set
```

### Credentials

This mod uses the credentials configured in the [Steampipe Snowflake plugin](https://hub.steampipe.io/plugins/turbot/snowflake).

### Configuration

Several benchmarks have [input variables](https://steampipe.io/docs/using-steampipe/mod-variables) that can be configured to better match your environment and requirements. Each variable has a default defined in its source file, e.g., `security_overview/network_security.sp`, but these can be overriden in several ways:

- Copy and rename the `steampipe.spvars.example` file to `steampipe.spvars`, and then modify the variable values inside that file
- Pass in a value on the command line:
  ```shell
  steampipe check benchmark.security_overview_network_security --var 'allowed_ips=["192.168.1.0/24", "172.10.1.0/24"]'
  ```
- Set an environment variable:
  ```shell
  SP_VAR_allowed_ips='["192.168.1.0/24", "172.10.1.0/24"]' steampipe check benchmark.security_overview_network_security
  ```
  - Note: When using environment variables, if the variable is defined in `steampipe.spvars` or passed in through the command line, either of those will take precedence over the environment variable value. For more information on variable definition precedence, please see the link below.

These are only some of the ways you can set variables. For a full list, please see [Passing Input Variables](https://steampipe.io/docs/using-steampipe/mod-variables#passing-input-variables).

## Get involved

- Contribute: [GitHub Repo](https://github.com/turbot/steampipe-mod-snowflake-compliance)
- Community: [Slack Channel](https://steampipe.io/community/join)
