#/bin/sh

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

sed -i'' -Ee 's/@reboot.*//' /var/spool/cron/root
