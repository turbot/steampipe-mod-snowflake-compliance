mod "snowflake_compliance" {
  # hub metadata
  title         = "Snowflake Compliance"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks across all your Snowflake accounts using Steampipe."
  color         = "#29B5E8"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/snowflake-compliance.svg"
  categories    = ["snowflake", "compliance", "security"]

  opengraph {
    title       = "Steampipe Mod for Snowflake Compliance"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks across all your Snowflake accounts using Steampipe."
    image       = "/images/mods/turbot/snowflake-compliance-social-graphic.png"
  }

  requires {
    plugin "snowflake" {
      version = "0.0.2"
    }
  }
}
