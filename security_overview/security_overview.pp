locals {
  security_overview_common_tags = merge(local.snowflake_compliance_common_tags, {
    security_overview = "true"
  })
}

benchmark "security_overview" {
  title         = "Snowflake Security Overview and Best Practices"
  description   = "Snowflake security overview and best practices provides an overview of security features and best practice guidelines for securing data in Snowflake."
  documentation = file("./security_overview/docs/security_overview.md")
  children = [
    benchmark.security_overview_data_encryption,
    benchmark.security_overview_iam,
    benchmark.security_overview_monitoring,
    benchmark.security_overview_network_security,
  ]

  tags = merge(local.security_overview_common_tags, {
    type = "Benchmark"
  })
}
