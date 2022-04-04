# Snowflake Compliance Scanning Tool

20+ checks covering industry defined security best practices across all Snowflake accounts.

## Quick start

1. Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```shell
brew tap turbot/tap
brew install steampipe

steampipe -v
steampipe version 0.13.3
```

2. Install the Snowflake plugin

```shell
steampipe plugin install snowflake
```

3. Clone this repo

```sh
git clone https://github.com/turbot/steampipe-mod-snowflake-compliance.git
cd steampipe-mod-snowflake-compliance
```

4. Run all benchmarks:

```shell
steampipe check all
```

### Other things to checkout

Run an individual benchmark:

```shell
steampipe check benchmark.security_overview_iam
```

Use Steampipe introspection to view all current controls:

```
steampipe query "select resource_name from steampipe_control"
```

Run a specific control:

```shell
steampipe check control.security_overview_iam_user_default_role_is_set
```

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

## Contributing

If you have an idea for additional compliance controls, or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing. (Even if you just want to help with the docs.)

- **[Join our Slack community →](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)** and hang out with other Mod developers.
- **[Mod developer guide →](https://steampipe.io/docs/using-steampipe/writing-controls)**

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-snowflake-compliance/blob/main/LICENSE).

`help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Snowflake Compliance Mod](https://github.com/turbot/steampipe-mod-snowflake-compliance/labels/help%20wanted)
