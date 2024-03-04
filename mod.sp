mod "snowflake_compliance" {
  # hub metadata
  title         = "Snowflake Compliance"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks across all your Snowflake accounts using Powerpipe and Steampipe."
  color         = "#29B5E8"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/snowflake-compliance.svg"
  categories    = ["snowflake", "compliance", "security"]

  opengraph {
    title       = "Powerpipe Mod for Snowflake Compliance"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks across all your Snowflake accounts using Powerpipe and Steampipe."
    image       = "/images/mods/turbot/snowflake-compliance-social-graphic.png"
  }

  require {
    plugin "snowflake" {
      min_version = "0.0.2"
    }
  }
}
