# Born2beauto cheat sheet

## status
Partly automatic

## installation procedure
make sure a virtual cdrom containing the ks.cfg is attached to the virtual
machine
make sure port forwarding is set up on the following ports and protocols:
- 8096/tcp
  - Jellyfin
- 8920/tcp
  - Jellyfin
- 1900/udp
  - Jellyfin
- 7359/udp
  - Jellyfin
- 8080/tcp
  - Wordpress
- 8081/tcp
  - Wordpress
- 3306/tcp
  - Wordpress
- 9000/tcp
  - Wordpress
- 4242/tcp
  - ssh
during first install, press tab to display all options for the bootloader,
append `inst.ks=cdrom` to the list of options.
wait until the virtual machine reboots
once it has rebooted, unlock the luks partition using the password 'Born2beauto'
log in using either the virtual machine itself, or ssh (whatever you prefer)
run the command `sudo wpsetup.sh`, this may take upwards of 3 minutes to
complete.
    - You can do this using sshpass as follows:
    `sshpass -p Born2beauto ssh -p 4242 localhost -t 'sudo wpsetup.sh'`
go to http://localhost:8080 to finish setting up wordpress
go to http://localhost:8096 to finish setting up jellyfin

## information

password=Born2beauto
comes preconfigured with Johnny Bravo (1997) in the /home/mde-beer/videos
directory

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
uptime post-install script = 3~ min
