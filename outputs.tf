output "nginx_server_public_ip" {
  description = "IP publica de instancia EC2 nginx"
  value       = module.nginx_server.server_public_ip
}

output "nginx_server_public_dns" {
  description = "IP publica de instancia EC2 nginx"
  value       = module.nginx_server.server_public_dns
}

output "mariadb_server_public_dns" {
  description = "IP publica de instancia EC2 mariadb"
  value       = module.mariadb_server.server_public_dns
}

output "nginx_key_pair_id" {
  description = "ID key pair de instancia EC2 nginx"
  value       = module.nginx_server.key_pair_id
}

output "mariadb_key_pair_id" {
  description = "ID key pair de instancia EC2 mariadb"
  value       = module.mariadb_server.key_pair_id
}