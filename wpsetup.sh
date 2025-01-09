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
echo "<?php
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'AUTH_KEY',         'put your unique phrase here' );
define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
define( 'NONCE_KEY',        'put your unique phrase here' );
define( 'AUTH_SALT',        'put your unique phrase here' );
define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
define( 'NONCE_SALT',       'put your unique phrase here' );
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}
define('DB_NAME', 'wordpress');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', 'Born2beauto');
define('DB_HOST', 'localhost');
require_once ABSPATH . 'wp-settings.php';" > /var/www/lighttpd/wp-config.php

sudo dnf config-manager -y --set-enabled crb
sudo dnf install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm
sudo dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm -y
sudo dnf config-manager -y --set-enabled rpmfusion-free-updates-testing
sudo dnf install -y jellyfin
sudo systemctl enable --now jellyfin
sudo firewall-cmd --permanent --add-service=jellyfin
sudo firewall-cmd --reload
mkdir /home/mde-beer/videos
chmod -R 766 /home/mde-beer
wget -O /home/mde-beer/videos/ 'https://archive.org/compress/johnnybravo1997/formats=MPEG4&file=/johnnybravo1997.zip'
unzip /home/mde-beer/videos/*.zip
rm -f /bin/wpsetup.sh
echo "cleanup done!"
