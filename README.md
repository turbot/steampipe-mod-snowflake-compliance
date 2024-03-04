# Snowflake Compliance Mod for Steampipe

15+ checks covering industry defined security best practices across all Snowflake accounts.

Run checks in a dashboard:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-snowflake-compliance/main/docs/snowflake_compliance_dashboard.png)

Or in a terminal:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-snowflake-compliance/main/docs/snowflake_compliance_terminal.png)

Includes support for:
* [Snowflake Security Overview and Best Practices](https://hub.steampipe.io/mods/turbot/snowflake_compliance/controls/benchmark.security_overview)

## Documentation

- **[Benchmarks and controls →](https://hub.steampipe.io/mods/turbot/snowflake_compliance/controls)**
- **[Named queries →](https://hub.steampipe.io/mods/turbot/snowflake_compliance/queries)**

## Getting Started

### Installation

Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install steampipe
```

Install the Snowflake plugin with [Steampipe](https://steampipe.io):

```sh
steampipe plugin install snowflake
```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-snowflake-compliance.git
cd steampipe-mod-snowflake-compliance
```

### Usage

Start your dashboard server to get started:

```sh
steampipe dashboard
```

By default, the dashboard interface will then be launched in a new browser
window at http://localhost:9194. From here, you can run benchmarks by
selecting one or searching for a specific one.

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `steampipe check` command:

Run all benchmarks:

```sh
steampipe check all
```

Run a single benchmark:

```sh
steampipe check benchmark.security_overview
```

Run a specific control:

```sh
steampipe check control.security_overview_iam_user_default_role_is_set
```

Different output formats are also available, for more information please see
[Output Formats](https://steampipe.io/docs/reference/cli/check#output-formats).

### Credentials

This mod uses the credentials configured in the [Steampipe Snowflake plugin](https://hub.steampipe.io/plugins/turbot/snowflake).

### Configuration

Several benchmarks have [input variables](https://steampipe.io/docs/using-steampipe/mod-variables) that can be configured to better match your environment and requirements. Each variable has a default defined in its source file, e.g., `security_overview/network_security.sp`, but these can be overriden in several ways:

- Copy and rename the `steampipe.spvars.example` file to `steampipe.spvars`, and then modify the variable values inside that file
- Pass in a value on the command line:
  ```sh
  steampipe check benchmark.security_overview_network_security --var 'allowed_ips=["192.168.1.0/24", "172.10.1.0/24"]'
  ```
- Set an environment variable:
  ```sh
  SP_VAR_allowed_ips='["192.168.1.0/24", "172.10.1.0/24"]' steampipe check benchmark.security_overview_network_security
  ```
  - Note: When using environment variables, if the variable is defined in `steampipe.spvars` or passed in through the command line, either of those will take precedence over the environment variable value. For more information on variable definition precedence, please see the link below.

These are only some of the ways you can set variables. For a full list, please see [Passing Input Variables](https://steampipe.io/docs/using-steampipe/mod-variables#passing-input-variables).

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Steampipe](https://steampipe.io) is a product produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). It is distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #steampipe on Slack →](https://turbot.com/community/join)**

Want to help but don't know where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Snowflake Compliance Mod](https://github.com/turbot/steampipe-mod-snowflake-compliance/labels/help%20wanted)