# stuff that isnt set up automatically

sudo setsebool -P httpd_setrlimit on
mysql_secure_installation <<EOF

n
y
y
y
y
EOF

sudo chown lighttpd:lighttpd /var/run/php-fpm/wp-config.php

mv /var/www/html /var/www/lighttpd
