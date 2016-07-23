#!/bin/bash

# update system
sudo yum update -y

# set up httpd
sudo yum install -y httpd
sudo chkconfig httpd on



sudo mkdir /var/www/vhosts/
sudo mkdir /var/www/vhosts/demo1.heyflu.com
sudo mkdir /var/www/vhosts/demo2.heyflu.com

# make a backup of httpd.conf
sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak 

# disable NameVirtualHost
#sudo sed -i "/^NameVirtualHost/ s/^/#/" /etc/httpd/conf/httpd.conf

# enable NameVirtualHost
sudo sed -i "/^#NameVirtualHost/ s/#*//" /etc/httpd/conf/httpd.conf



echo "<VirtualHost *:80>
  ServerName demo1.heyflu.com
  DocumentRoot /var/www/vhosts/demo1.heyflu.com
  <Directory /var/www/vhosts/demo1.heyflu.com>
    AllowOverride All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName demo2.heyflu.com
  DocumentRoot /var/www/vhosts/demo2.heyflu.com
  <Directory /var/www/vhosts/demo2.heyflu.com>
    AllowOverride All
  </Directory>
</VirtualHost>
" | sudo tee --append /etc/httpd/conf.d/vhost.conf


echo "<h1>demo1</h1>" | sudo tee --append /var/www/vhosts/demo1.heyflu.com/index.html
echo "<h1>demo2</h1>" | sudo tee --append /var/www/vhosts/demo2.heyflu.com/index.html

sudo service httpd start
