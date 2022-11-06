#!/bin/bash
echo "1) New Machine ?"
echo "2) Old Machine?"
echo "3) Connect VPN"
echo "4) Exit"
read -p "Enter the options: " option
case $option in
  1)
  	read -p "Enter the ip address: " ip 
	if [[ "$ip" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
	read -p "Enter the name of the machine:" name
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
	nmap -A  $ip >> $name/nmap/nmap.txt
	echo "Scanned the IP:$ip using Nmap" >> $name/status.txt
	echo "[+] Running Gobuster on the target"
	gobuster dir -u $ip -w /usr/share/dirb/wordlists/common.txt >> $name/gobuster/scan.txt
	echo "Scanned the IP:$ip using Gobuster" >> $name/status.txt
	else
  		echo "Invalid IP Address"
  		exit 1
	fi
    	;;
  2)
    echo "Welcome Back Sir!"
    echo "Here are your Solved/Ongoing Machine :"
    sleep 1
    ls
    read -p "Enter the name of the machine:" machine
    cd $machine
    if [ ! -f status ]; then
    	echo "No Status File Found"
    else
    	sleep 2
    	gedit status
    fi		
    ;;
  3)
  sleep 2
  echo "[+] Setting up the VPN "
  sudo openvpn Venkatesh007.ovpn
  ;;
  4)
  echo "Thank you"
  exit 1
  ;;
  *)
  echo "Choose the correct options"
    ;;
esac
