query "manual_control" {
  sql = <<-EOQ
    select
      account as resource,
      'info' as status,
      'Manual verification required.' as reason,
      account
    from
      snowflake_user
    limit 1;
  EOQ
}