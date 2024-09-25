#!/bin/bash

apt update -y
apt list --upgradable
apt install redis-tools -y
apt install nginx -y
systemctl enable nginx
systemctl start nginx
echo "<html>
<head><title>Hola Usuario de Cloudhesive</title></head>
<body>
<h1>Hola Usuario de Cloudhesive</h1>
<p>Bienvenido a su servidor NGINX en la nube</p>
</body>
</html>" > /var/www/html/index.nginx-debian.html
systemctl reload nginx
exit