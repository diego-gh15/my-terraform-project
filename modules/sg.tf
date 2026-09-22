resource "aws_security_group" "sg" {
  name        = "${var.server_name}-sg"
  description = "Security group allowing SSH and HTTP access"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "sg-ir-ssh" {
  count = var.enable_ssh_port ? 1 : 0

  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = var.my_public_ip
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "sg-ir-http" {
  count = var.enable_http_port ? 1 : 0

  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "eg-outbund" {
  security_group_id = aws_security_group.sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "mariadb-server-sg-ir" {
  #count = var.nginx_security_group_id !=null ? 1 : 0
  count = var.enable_mariadb_port ? 1 : 0

  security_group_id            = aws_security_group.sg.id
  referenced_security_group_id = var.nginx_security_group_id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}
