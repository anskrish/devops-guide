output "project_id" {
  value       = var.project_id
  description = "The project to run tests against"
}

output "name" {
  description = "The name for Cloud SQL instance"
  value       = module.private_mysql.instance_name
}

output "mysql_conn" {
  value       = module.private_mysql.instance_connection_name
  description = "The connection name of the master instance to be used in connection strings"
}

#output "mysql_user_pass" {
#  value       = module.private_mysql.generated_user_password
#  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
#}


output "public_ip_address" {
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance"
  value       = module.private_mysql.public_ip_address
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
  value       = module.private_mysql.private_ip_address
}

