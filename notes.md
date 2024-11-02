# checklist

- 2+ encrypted LVM partitions
- SSH service on port 4242
 - *only* open port btw
- strong password policy
 - expire every 30 days
 - min days before modification 2
 - warning message 7 days before expiration date
 - min 10 char long
 - uppercase, lowercase and digit required
 - max 3 identical characters in a row
 - cannot include user's username
 - for non-root passwords:
  - at least 7 characters not part of former password
 - root password must comply with rules
 - example passwords
  - valid
   - AmogusImp0st0r (root)
   - When_the_amongus_impostor_vents_for_the_2nd_time (mde-beer)
   - The_g0blin_h0ards_many_treasures (encryption passphrase)
   - jan_Alitote_li_tawa_sike_e_sik3 (ssh-key)
  - invalid
   - mde-beer'sFunnypassw0rd
   - ionlywriteinlowercase
   - IAMVERYHUMANYES
   - 13375934k933k
   - My_awesome_password_0000
- config opsystem with firewalld
- hostname == mde-beer42
- install and config strict sudo rules
 - max 3 attempts in the event of wrong password when using sudo
 - custom message for wrong password when using sudo
 - all sudo actions have to be logged in /var/log/sudo (input and output)
 - TTY mode has to be enabled
 - restrict sudo paths, ex:
  - /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
- minimum users:
 - root
 - mde-beer
  - has to belong to sudo and user42 groups
- make monitoring.sh (in bash)
 - run at startup and every 10 minutes
 - banner is optional
 - must display:
  - OS-architecture and kernel version
  - number of physical and virtual processors
  - current available ram and its usage as a percentage
  - current storage available and its usage as a percentage
  - current utilization of processors as a percentage
  - date and time of last reboot
  - wether LVM is active or nah
  - number of active connections
  - number of users using server
  - ipv4 adress and mac adress
  - number of commands executed by sudo
  -

# actual procedure
i went with the graphical installer (easier)
i set up a root password, decided to encrypt everything (setting up LVM after install presumably), made the user mde-beer and put them in the correct groups, as well as giving a good password to it. changed the hostname from localhost to mde-beer42 (presumably that is what they want us to do), did not get to set up any security protocols yet, but i assume that can be done once im actually in the system.
i disabled KDUMP, cuz i didnt want to deal with its quirks on encrypted devices (it told me it had some of those)
monitoring.sh seems like a cakewalk, stealing most of it from gobfetch probably. if i can find it.
