### EC2 instance ###
variable "ami_id" {
  type        = string
  description = "ID de AMI para instancia EC2 nginx-server"
  default     = "ami-081b0a6eac00b4f53"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancie EC2 de nginx-server"
  default     = "t2.nano"
}

variable "server_name" {
  type        = string
  description = "Nombre del servidore web"
  default     = "nginx-server"
}

variable "public_key" {
  type        = string
  description = "Contenido de la clave publica SSH"
}

variable "user_data" {
  type        = string
  description = "Defines script to be executed"
}

variable "enable_mariadb_port" {
  type        = bool
  description = "Flag to enable 3306 port in sg"
  default     = false
}

variable "nginx_security_group_id" {
  type        = string
  description = "Optional Security Group ID of the Nginx server to allow incoming MariaDB traffic"
  default     = null
}

variable "enable_http_port" {
  type        = bool
  description = "Defines if http port is enabled in sg"
  default     = false
}

variable "enable_ssh_port" {
  type        = bool
  description = "Flag to enable SSH port 22 ingress"
  default     = false
}

variable "my_public_ip" {
  type        = string
  description = "Public IP of my local computer"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}