# AWS Infrastructure & DevSecOps CI/CD Pipeline

Automated, secure, and modular AWS infrastructure deployment using **Terraform** and **GitHub Actions**.
This project provisions a two-tier architecture (Nginx Web Tier & MariaDB Database Tier) featuring S3 remote state management, AWS OpenID Connect (OIDC) authentication, fileless key injection, and strict security group isolation.

---

## 🏛️ Architecture Overview

```text
               +-------------------------------------------+
               |          Internet / Public Access         |
               +-------------------------------------------+
                                     |
                          HTTP (80)  |  SSH (22)
                                     v
               +-------------------------------------------+
               |          Nginx Web Server (EC2)           |
               |        Security Group: nginx-sg           |
               +-------------------------------------------+
                                     |
                                     |  MariaDB (3306)
                                     |  (SG-to-SG Ingress Only)
                                     v
               +-------------------------------------------+
               |         MariaDB Server (EC2)              |
               |        Security Group: mariadb-sg         |
               +-------------------------------------------+
