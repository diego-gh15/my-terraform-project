#!/bin/bash
dnf install nginx -y
systemctl enable --now nginx