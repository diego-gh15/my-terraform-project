# AWS Infrastructure Automation with Terraform & GitHub Actions (OIDC)

Este repositorio contiene la configuración de Infraestructura como Código (IaC) para desplegar una arquitectura segura de dos capas en AWS (Nginx Web Server y MariaDB Database Server) utilizando módulos reutilizables de Terraform y un pipeline automatizado de CI/CD con GitHub Actions autenticado vía OpenID Connect (OIDC).

---

## 📐 Arquitectura de Red e Infraestructura

La infraestructura desplegada se compone de los siguientes elementos:

* **VPC:** Módulo de red personalizado con rango CIDR `10.0.0.0/16`.
* **Subred Pública:** Aloja el servidor web Nginx y el NAT Gateway.
* **Subred Privada:** Aloja el servidor MariaDB sin acceso directo desde Internet.
* **Seguridad (Security Groups):**
  * **Nginx SG:** Permite tráfico HTTP (puerto 80) global y acceso SSH (puerto 22) restringido exclusivamente a la IP pública del administrador.
  * **MariaDB SG:** Restringe el tráfico en el puerto 3306 únicamente a las solicitudes provenientes del Security Group del servidor Nginx.
* **NAT Gateway & Internet Gateway:** Permiten salida a Internet a las instancias en la subred privada y pública respectivamente.

---

## 🛠️ Tecnologías Utilizadas

* **Cloud Provider:** Amazon Web Services (AWS)
* **IaC:** Terraform (Backend en AWS S3)
* **CI/CD:** GitHub Actions (Pipelines en 2 jobs: CI y CD)
* **Seguridad & Auth:** AWS IAM OIDC (Autenticación Keyless desde GitHub Actions)

---

## 🚀 Pipeline CI/CD (GitHub Actions)

El flujo de trabajo `.github/workflows/deploy.yml` implementa las siguientes etapas:

1. **Autenticación Segura (OIDC):** Se elimina el uso de credenciales estáticas de AWS (`AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`) mediante la asunción temporal de un rol IAM a través de tokens OIDC.
2. **Job CI (Integración Continua):**
   * Validación de formato y sintaxis (`terraform validate`).
   * Generación del plan de ejecución (`terraform plan -out=tfplan`) inyectando variables sensibles mediante `TF_VAR_`.
   * Publicación del plan como un artefacto cifrado temporal (`upload-artifact`).
3. **Job CD (Despliegue Continuo):**
   * Descarga del artefacto `tfplan`.
   * Ejecución controlada (`terraform apply tfplan`) activada únicamente tras hacer *push* en la rama `main`.

---

## 🗝️ Variables y Secretos Requeridos

Para ejecutar este proyecto en tu propio entorno de GitHub Actions, debes configurar los siguientes **Repository Secrets** en GitHub:

| Secret Name | Descripción |
| :--- | :--- |
| `AWS_ACCOUNT_ID` | Número de cuenta de AWS donde reside el rol OIDC. |
| `SSH_PUBLIC_KEY` | Clave pública SSH para inyectar en las instancias EC2 via `aws_key_pair`. |
| `MY_PUBLIC_IP` | IP pública con máscara CIDR (ej. `X.X.X.X/32`) para habilitar el acceso SSH en el SG. |

---

## 📂 Estructura del Repositorio

```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml       # Definición del pipeline de CI/CD
├── modules/
│   ├── ec2.tf              # Recurso EC2 reutilizable
│   ├── key.tf              # Par de claves SSH
│   ├── sg.tf               # Reglas de Security Groups
│   ├── variables.tf        # Variables de entrada del módulo
│   └── outputs.tf          # Salidas exportadas del módulo
├── scripts/
│   ├── nginx.sh            # User Data Script para Nginx
│   └── mariadb.sh          # User Data Script para MariaDB
├── .gitignore              # Archivos excluidos de Git
├── .terraform.lock.hcl     # Archivo de bloqueo de dependencias
├── main.tf                 # Invocación de módulos (Nginx y MariaDB)
├── outputs.tf              # IPs y DNS públicos generados
├── provider.tf             # Configuración del Backend S3 y AWS Provider
├── variables.tf            # Variables globales raíz
└── vpc.tf                  # Definición de VPC, Subnets y Route Tables