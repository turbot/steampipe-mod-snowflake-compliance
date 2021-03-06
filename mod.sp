// Benchmarks and controls for specific services should override the "service" tag
locals {
  snowflake_compliance_common_tags = {
    category = "Compliance"
    plugin   = "snowflake"
    service  = "Snowflake"
  }
}

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

  require {
    steampipe = "0.13.1"
    plugin "snowflake" {
      version = "0.0.2"
    }
  }
}
