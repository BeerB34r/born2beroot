#!/bin/sh

# get architecture
ARCH=$(uname -a)
# get and split up CPU info
CPU=$(lscpu | grep -Ee '^CPU\(s\):\s+' -e 'Core\(s\)' -e 'Socket\(s\):' | sed -E 's/[^0-9]//g')
PHYS=$(echo $CPU | cut -f 1 -d ' ')
VIRT=$(($(echo $CPU | cut -f 2- -d ' ' | tr ' ' '*')))
# get 15min load avg
LOAD=$(cut -f 3 -d ' ' /proc/loadavg)
# get, split and format memory (RAM) information
MEMINFO=$(head -n 3 /proc/meminfo | cut -f 2 -d ':' | tr -d ' ')
MEMTOTAL=$(( $(echo $MEMINFO | cut -f 1 -d ' ' | tr -d 'kB') / 1024 ))
MEMFREE=$(echo $MEMINFO | cut -f 2 -d ' ' | head -n 1 | tr -d 'kB')
MEMUSED=$(( ( $MEMTOTAL ) - ( $MEMFREE / 1024 ) ))
MEM_USE=$(echo $MEMUSED/$MEMTOTAL mB \($(( ( $MEMUSED * 100 ) / $MEMTOTAL ))%\) )
# get, split and format disk information
DISKINFO=$(df -a --total -BG | tail -n 1 | tr -d ' total-')
DISKTOTAL=$(echo $DISKINFO | cut -f 1 -d 'G')
DISKUSE=$(echo $DISKINFO | cut -f 2 -d 'G')
DISKPERC=$(echo $DISKINFO | cut -f 4 -d 'G')
DISK_USE=$(echo $DISKUSE/$DISKTOTAL gB \($DISKPERC\))
# get last boot time
BOOT=$(echo "$(uptime -p) ($(uptime -s))")
# count amount of tcp entries whose state is 'established'
TCP=$(ss -A tcp state established -H | wc -l)
# check if any block is of type 'lvm'
LVM=$(if [ -n "$(lsblk -o TYPE | grep lvm)" ] ; then echo "on" ; else echo "off" ; fi)
# who -q == user count
USER_COUNT=$(who -q | tail -n 1 | cut -f 2 -d '=')
USERS=$(who -q | head -n 1)
# hostname and mac adress one liners
IP=$(hostname -I)
MAC=$(cat /sys/class/net/enp*/address)
# when the journal is controlled
SUDO=$(sudo journalctl _COMM=sudo | wc -l)
wall "
#Architecture 			$ARCH
#CPU 				P-$PHYS V-$VIRT LOAD-$LOAD
#Memory 			$MEM_USE
#Disk 				$DISK_USE
#Last boot 			$BOOT
#LVMs 				$LVM
#TCP connections		$TCP
#Users				$USER_COUNT ($USERS)
#Network			$IP ($MAC)
#Sudo tally			$SUDO
"
