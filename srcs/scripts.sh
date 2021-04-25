openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=RU/ST=Kazan/L=Kazan/O=21/OU=hguini/CN=localhost"

service nginx start
service mysql start

mysql -u root --skip-password -e "create database Max_db;"
mysql -u root --skip-password -e "create user 'admin'@'localhost' identified by 'pass1';"
mysql -u root --skip-password -e "grant all privileges on Max_db.* to 'admin'@'localhost';"
mysql -u root --skip-password -e "flush privileges;"

service php7.3-fpm start
bash
