#/bin/sh

echo "restarting services"
sudo systemctl restart mariadb
sudo systemctl restart php-fpm
sudo systemctl restart lighttpd
echo "services restarted"
sudo mysql_secure_installation <<EOF

n
n
y
y
y
y
EOF

sudo mysql -u root -password=Born2beauto <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'Born2beauto';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EOF
echo "databases initialised"
sudo systemctl restart mariadb
sudo systemctl restart php-fpm
sudo systemctl restart lighttpd
#sed -i'' -Ee 's/@reboot.*//' /var/spool/cron/root
sudo sed -i'' -Ee "s/define\(.*\'DB_NAME.*//" -e "s/define\(.*\'DB_USER.*//" -e "s/define\(.*\'DB_PASSWORD.*//" -e "s/define\(.*\'DB_HOST.*//" -e "s/require_once.*//" /var/www/lighttpd/wp-config.php
echo "define('DB_NAME', 'wordpress');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', 'Born2beauto');
define('DB_HOST', 'localhost');
require_once ABSPATH . 'wp-settings.php';" >> /var/www/lighttpd/wp-config.php
rm -f /bin/wpsetup.sh
echo "cleanup done!"
