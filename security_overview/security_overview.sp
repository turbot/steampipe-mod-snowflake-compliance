benchmark "security_overview" {
  title         = "Snowflake Security Overview and Best Practices"
  description   = "TODO"
  documentation = file("./security_overview/docs/security_overview.md")
  children = [
    benchmark.security_overview_iam,
    benchmark.security_overview_monitoring,
    benchmark.security_overview_network_security
  ]
}

