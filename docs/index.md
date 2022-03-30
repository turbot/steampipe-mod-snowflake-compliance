---
repository: "https://github.com/turbot/steampipe-mod-snowflake-compliance"
---

# Snowflake Compliance Mod

Run individual configuration, compliance and security controls or full compliance benchmarks for `Security overview and best practice` across all your Snowflake accounts.

![image](https://raw.githubusercontent.com/turbot/steampipe-mod-snowflake-compliance/main/docs/snowflake_cis_v140_console.png)

## References

[Snowflake](https://snowflake.com/) is a single, integrated platform delivered as-a-service. It features storage, compute, and global services layers that are physically separated but logically integrated. Data workloads scale independently from one another, making it an ideal platform for data warehousing, data lakes, data engineering, data science, modern data sharing, and developing data applications.

[Snowflake security overview and best practices](https://community.snowflake.com/s/article/Snowflake-Security-Overview-and-Best-Practices) provides an overview of security features and best practice guidelines for securing your data in Snowflake.

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
steampipe check benchmark.cis_v140
```

Run a specific control:

```shell
steampipe check control.cis_v140_2_1_1
```

### Credentials

This mod uses the credentials configured in the [Steampipe Snowflake plugin](https://hub.steampipe.io/plugins/turbot/snowflake).

### Configuration

No extra configuration is required.

## Get involved

- Contribute: [GitHub Repo](https://github.com/turbot/steampipe-mod-snowflake-compliance)
- Community: [Slack Channel](https://steampipe.io/community/join)
