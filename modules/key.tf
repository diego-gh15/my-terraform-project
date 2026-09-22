resource "aws_key_pair" "key_ssh" {
  key_name   = "${var.server_name}-ssh"
  public_key = var.public_key
}