# Born2beauto cheat sheet

## status
Partly automatic, single script to finish rest

## information

password=Born2beauto

## complications
if any prompt were to appear, at any time, during the post-install script, the
installation will hang forever
heredocs are the devil, and i couldnt get it to work properly with the install
script
sql isnt automatically set up, trying now by prepending 'sudo systemctl restart
mariadb'
no way that ive found allows for the script to set up sql without the users
direct input (running the command). thus it has been shortened to `sudo
wpsetup.sh`

## statistics

uptime start-to-finish = 9~ min
