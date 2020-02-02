#! /bin/bash
yum install httpd -y
chkconfig httpd on
service httpd start
echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html