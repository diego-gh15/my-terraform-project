#!/bin/bash
dnf install mariadb105-server -y
systemctl enable --now mariadb