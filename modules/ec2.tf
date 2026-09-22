resource "aws_instance" "server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  /*user_data           = <<-EOF
                            #!/bin/bash
                            dnf install nginx -y
                            systemctl enable --now nginx
                            EOF*/
  user_data                   = var.user_data
  user_data_replace_on_change = true
  key_name                    = aws_key_pair.key_ssh.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.sg.id]

  tags = {
    Name = var.server_name
  }
}