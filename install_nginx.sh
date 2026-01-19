#!/bin/bash

sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
echo "Hello from Nginx installed via Terraform!" | sudo tee /var/www/html/index.html
