#!/bin/sh

tar -zxf /tmp/latest-en_CA.tar.gz -C /tmp && echo "`if [ $? -eq 0 ]; then echo "1- Extracting latest-en_CA.tar.gz: Done"; else echo "1- Extracting latest-en_CA.tar.gz: ERROR, Files didn't extract";fi`" >> /var/log/script.log
	
mv -f /tmp/wordpress/* /var/www/html/ && echo "`if [ $? -eq 0 ]; then echo "2- Moving files to html dir: Done"; else echo "2- Moving files to html dir: ERROR";fi`" >> /var/log/script.log
	
rm -rf /tmp/latest-en_CA.tar.gz /tmp/wordpress && echo "`if [ $? -eq 0 ]; then echo "3- Deleteing latest-en_CA.tar.gz: Done"; else echo "3- Deleteing latest-en_CA.tar.gz: ERROR";fi`" >> /var/log/script.log

rm /etc/nginx/conf.d/default.conf && echo "`if [ $? -eq 0 ]; then echo "4- Removing nginx default vhost file: Done"; else echo "4- Removing nginx default vhost file: ERROR";fi`" >> /var/log/script.log

mkdir -p /run/php /run/nginx /var/www/html && echo "`if [ $? -eq 0 ]; then echo "5- Creating /run/php dir: Done"; else echo "5- Creating /run/php dir: ERROR";fi`" >> /var/log/script.log

rm /tmp/conf/supervisor.conf /tmp/conf/.my.cnf

mv /tmp/conf/wordpress.conf /etc/nginx/conf.d/wordpress.conf && nginx -s reload && echo "`if [ $? -eq 0 ]; then echo "6- Moving wordpress.conf to /etc/nginx/sites-enabled/wordpress.conf: Done"; else echo "6- Moving wordpress.conf to /etc/nginx/sites-enabled/wordpress.conf: ERROR";fi`" >> /var/log/script.log

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php && echo "`if [ $? -eq 0 ]; then echo "7- Creating wp-config.php from sample: Done"; else echo "7- Creating wp-config.php from sample: ERROR";fi`" >> /var/log/script.log

chown -R nginx:nginx /var/www/html/ && echo "`if [ $? -eq 0 ]; then echo "8- Editing permissions: Done"; else echo "8- Editing permissions: ERROR";fi`" >> /var/log/script.log

source /tmp/conf/db.env

sed -i -e "s/database_name_here/$MYSQL_DATABASE/g" /var/www/html/wp-config.php && echo "`if [ $? -eq 0 ]; then echo "9- DB name configuration in wp-config.php: Done"; else echo "9- DB name configuration in wp-config.php: ERROR";fi`" >> /var/log/script.log

sed -i -e "s/username_here/$MYSQL_USER/g" /var/www/html/wp-config.php && echo "`if [ $? -eq 0 ]; then echo "10- DB user configuration in wp-config.php: Done"; else echo "10- DB user configuration in wp-config.php: ERROR";fi`" >> /var/log/script.log

sed -i -e "s/password_here/$MYSQL_PASSWORD/g" /var/www/html/wp-config.php && echo "`if [ $? -eq 0 ]; then echo "11- DB password configuration in wp-config.php: Done"; else echo "11- DB password configuration in wp-config.php: ERROR";fi`" >> /var/log/script.log

sed -i -e 's/localhost/database/g' /var/www/html/wp-config.php && echo "`if [ $? -eq 0 ]; then echo "12- DB host configuration in wp-config.php: Done"; else echo "12- DB host configuration in wp-config.php: ERROR";fi`" >> /var/log/script.log

cp -f /tmp/conf/www.conf /etc/php7/php-fpm.d/www.conf && pkill php-fpm7 && echo "`if [ $? -eq 0 ]; then echo "13- Move www.conf to /etc/php7/php-fpm.d/www.conf: Done"; else echo "13- Move www.conf to /etc/php7/php-fpm.d/www.conf: ERROR";fi`" >> /var/log/script.log


echo "define('FS_METHOD','direct');" >> /var/www/html/wp-config.php
