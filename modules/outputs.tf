output "server_public_ip" {
  description = "IP publica de instancia EC2 nginx-server"
  value       = aws_instance.server.public_ip
}

output "server_public_dns" {
  description = "DNS publico de instancia EC2 nginx-server"
  value       = aws_instance.server.public_dns
}

output "key_pair_id" {
  description = "ID de key pair"
  value       = aws_key_pair.key_ssh.id
}

output "security_group_id" {
  description = "The ID of the security group created by this module"
  value       = aws_security_group.sg.id
}