### Default Tags ###
variable "project" {
  type        = string
  description = "Proyecto del recurso"
  default     = "my-project"
}

variable "environment" {
  type        = string
  description = "Ambiente del recurso"
  default     = "Dev"
}

variable "owner" {
  type        = string
  description = "Propietario del recurso"
  default     = "dgm"
}

variable "costcenter" {
  type        = string
  description = "Centro de costo"
  default     = "1234"
}

### AWS Region ###
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

### Key Pair ####

variable "public_key" {
  type        = string
  description = "Contenido de la clave publica SSH"
}

### My Public IP ###
variable "my_public_ip" {
  type        = string
  description = "Public IP of my local computer"
  default = "0.0.0./0"
}