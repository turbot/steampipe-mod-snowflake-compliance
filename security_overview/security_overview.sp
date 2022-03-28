benchmark "security_overview" {
  title         = "Snowflake Security Overview and Best Practices"
  description   = "TODO"
  documentation = file("./security_overview/docs/security_overview.md")
  children = [
    benchmark.iam,
    benchmark.monitoring,
    benchmark.network_security
  ]
}

