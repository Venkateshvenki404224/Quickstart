#!/bin/bash
echo "1) New Machine ?"
echo "2) Old Machine?"
echo "3) Connect VPN"
echo "4) Exit"
read -p "Enter the options: " option
if [ ! -d TryHackMe ]; then
	mkdir TryHackMe
fi	
case $option in
  1)
  	read -p "Enter the ip address: " ip 
	if [[ "$ip" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
	read -p "Enter the name of the machine:" name
	cd ~/TryHackMe
	if [ ! -d $name ]; then 
		mkdir $name
	else
	        echo "Directory Already exits"
	        read -p "Enter a differnt name:" name
	fi        
	if [ ! -d $name/nmap ]; then
		mkdir $name/nmap
	fi	
	if [ ! -d $name/gobuster ]; then
		mkdir $name/gobuster
	fi
	echo "[+] Folder Created"
  	echo "[+] Running Nmap "
  	echo "Command used is nmap -A -sC -sV  -p- <IP>"
	nmap -sC -sV -p- $ip >> $name/nmap/nmap
	echo "Scanned the IP:$ip using Nmap" >> $name/status
	echo "[+] Running Gobuster on the target"
	gobuster dir -u $ip -w /usr/share/dirb/wordlists/common.txt >> $name/gobuster/scan
	echo "Scanned the IP:$ip using Gobuster" >> $name/status
	else
  		echo "Invalid IP Address"
  		exit 1
	fi
    	;;
  2)
    echo "Welcome Back Sir!"
    sleep 1
    cd ~/TryHackMe
    ls -d */ > ~/TryHackMe/list
    [ -s ~/TryHackMe/list ] && result='pass' || result='fail'
    if [ $result == 'pass' ]; then
    	echo "Here are your Solved/Ongoing Machine :"
    	cat ~/TryHackMe/list
    	sleep 1
    	rm -r ~/TryHackMe/list
   	read -p "Enter the name of the machine:" machine
    	cd $machine
    	if [ ! -f status ]; then
    		echo "No Status File Found"
    	else
    		sleep 2
    		gedit status
    	fi	
    else
    	rm -r ~/TryHackMe/list
    	echo "Their is no Machine to list/Create a New Machine First"
    fi			
    	;;
  3)
     find ~/TryHackMe -name *.ovpn > ~/TryHackMe/path
     [ -s ~/TryHackMe/path ] && result='pass' || result='fail'
     if [ $result == 'pass' ]; then 
	value=`cat ~/TryHackMe/path` 
	rm -r ~/TryHackMe/path
	sudo openvpn $value  
     else
	echo "Please move your .ovpn configuration file to ~/TryHackMe"
	rm -r ~/TryHackMe/path
     fi
     ;;
  4)
  echo "Thank you"
  exit 1
  ;;
  *)
  echo "Choose the correct options"
    ;;
esac
