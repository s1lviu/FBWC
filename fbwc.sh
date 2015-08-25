################################################
PAROLA_SQL=" " #MySQL master password #
################################################
clear
if [ $# -eq 1 ]; then
    echo "Building configuration for $1"
    sudo mkdir -p "/var/www/$1"
    echo "server {
        listen       80;
        server_name  $1 www.$1;
        root /var/www/$1;
        index index.php index.html index.htm;
 
        location / {
            try_files \$uri \$uri/ =404;
        }
 
        error_page      500 502 503 504  /50x.html;
        location = /50x.html {
            root /usr/local/www/nginx-dist;
        }
 
        location ~ \.php\$ {
                try_files \$uri =404;
                fastcgi_split_path_info ^(.+\.php)(/.+)\$;
                fastcgi_pass unix:/var/run/php-fpm.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME \$request_filename;
                include fastcgi_params;
        }
    }
" >> "/usr/local/etc/nginx/vhosts/$1.conf"
echo "Success!"
echo "Configuration file patch for $1 is /usr/local/etc/nginx/vhosts/$1.conf"
service nginx restart
    exit 1
else
clear
echo "Start installing FEMP compontents on your FreeBSD"
sudo mkdir -p /usr/local/etc/nginx/vhosts
sudo mkdir -p /var/www
sudo pkg install -y nginx mysql56-server php56 php56-mysql nano expect

sudo echo "mysql_enable=\"YES\"
nginx_enable=\"YES\"
php_fpm_enable=\"YES\"
sendmail_enable=\"YES\"" >> /etc/rc.conf


search="listen = 127.0.0.1:9000"
replace="listen = /var/run/php-fpm.sock"
sed -i "" "s|${search}|${replace}|g" /usr/local/etc/php-fpm.conf


sudo echo "
listen.owner = www
listen.group = www
listen.mode = 0660
" >> /usr/local/etc/php-fpm.conf

sudo cp  /usr/local/etc/php.ini-production  /usr/local/etc/php.ini

sudo echo "cgi.fix_pathinfo=0" >> /usr/local/etc/php.ini

sudo service php-fpm start

sudo service mysql-server start

expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"\r\"

expect \"Set root password?\"
send \"Y\r\"

expect \"New password:\"
send \"$PAROLA_SQL\r\"

expect \"Re-enter new password:\"
send \"$PAROLA_SQL\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
"
 
sudo service mysql-server restart

sudo service nginx start

:> /usr/local/etc/nginx/nginx.conf

sudo echo 'user  www;
worker_processes  1;
error_log /var/log/nginx/error.log error;
 
events {
    worker_connections  1024;
}
 
http {
    include       mime.types;
    default_type  application/octet-stream;
 
    access_log /var/log/nginx/access.log;
 
    sendfile        on;
    keepalive_timeout  65;
 
     #virtual hosting
    include /usr/local/etc/nginx/vhosts/*;
    
}' >> /usr/local/etc/nginx/nginx.conf

sudo mkdir -p /var/log/nginx
sudo touch /var/log/nginx/access.log
sudo touch /var/log/nginx/error.log

sudo rm /usr/local/www/nginx
sudo mkdir /usr/local/www/nginx

sudo service sendmail restart
sudo service nginx restart

echo "
All done!"
fi