module "nginx_server" {
  source = "./modules"

  ami_id           = "ami-0e34b50e714a297f1"
  instance_type    = "t2.nano"
  server_name      = "nginx-server"
  public_key       = var.public_key
  enable_http_port = true
  enable_ssh_port  = true
  my_public_ip     = var.my_public_ip
  user_data        = file("${path.root}/scripts/nginx.sh")
  vpc_id           = aws_vpc.my-vpc.id
  subnet_id        = aws_subnet.public.id
}



module "mariadb_server" {
  source = "./modules"

  ami_id                  = "ami-0e34b50e714a297f1"
  instance_type           = "t2.micro"
  server_name             = "mariadb-server"
  public_key              = var.public_key
  enable_mariadb_port     = true
  nginx_security_group_id = module.nginx_server.security_group_id
  my_public_ip            = var.my_public_ip
  user_data               = file("${path.root}/scripts/mariadb.sh")
  vpc_id                  = aws_vpc.my-vpc.id
  subnet_id               = aws_subnet.private.id
}

