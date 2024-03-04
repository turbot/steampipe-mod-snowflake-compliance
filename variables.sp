// Benchmarks and controls for specific services should override the "service" tag
locals {
  snowflake_compliance_common_tags = {
    category = "Compliance"
    plugin   = "snowflake"
    service  = "Snowflake"
  }
}