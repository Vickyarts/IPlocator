#!/bin/bash
#Copyright (C) 2020 Vickyarts
#This script requires zenity
#Contact me github
green='\e[0;32m'
lightgreen='\e[1;32m'
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'
Escape="\033";
RedF="${Escape}[31m";
LighGreenF="${Escape}[92m"
YS="\e[1;33m" 
BS="\e[0;34m"
CE="\e[0m"
RS="\e[1;31m"
publicip=`dig +short myip.opendns.com @resolver1.opendns.com`
# check internet 
function checkinternet() 
{
ping -c 1 google.com > /dev/null 2>&1
if [[ "$?" != 0 ]]
then
	echo -e $yellow " Checking For Internet: ${RedF}FAILED"
	echo
	echo -e $red "This Script Needs An Active Internet Connection"
	echo
	echo -e $yellow " IPlocaltor Exit"
	echo && sleep 2
	exit
else
	echo -e $yellow " Checking For Internet: ${LighGreenF}CONNECTED"
fi
}
function depend()
{
#check dependencies existence
sleep 2
clear
echo -e $blue "" 
echo "® Checking dependencies configuration ®" 
echo " "
#check if zenity is installed
which zenity > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] Zenity............................${LighGreenF}[ found ]"
which zenity > /dev/null 2>&1
sleep 2
else
echo ""
echo -e $red "[ X ] Zenity -> ${RedF}not found! "
sleep 2
echo -e $yellow "[ ! ] Installing Zenity "
sleep 2
echo -e $green ""
sudo apt-get install zenity -y
clear
echo -e $blue "[ ✔ ] Done installing .... "
which zenity > /dev/null 2>&1
fi 
}
function banner()
{
	echo -e "                              ___ ____    _                    _                                       "          
	echo -e "                             |_ _|  _ \  | |    ___   ___ __ _| |_ ___  _ __                           "
	echo -e "                              | || |_) | | |   / _ \ / __/ _  | __/ _ \|  __|                          "
	echo -e "                              | ||  __/  | |__| (_) | (_| (_| | || (_) | |                             "
	echo -e "                             |___|_|     |_____\___/ \___\__,_|\__\___/|_|                             "
	echo ""                                                                                                       
	echo ""                                                                                                       
	sleep 2
	echo -e $red"                               ~ Changing Coder Name Wont Make You One :)                              "
	echo -e $blue"                                             ~ Vickyarts :)                                            "
	echo -e "                                                                                                       "
	echo "" 
}

function geolocate_ip()
{
	locbool=1
	echo -e ""$BS"Please wait..."$CE""
	A1="$1"
	AA1=$(is_it_an_ip "$A1")
	if [[ "$AA1" = 1 ]]
	then
		sleep 1
		echo -e ""$YS"Information:"$CE""
		country=$(curl ipinfo.io/"$A1"/country 2>/dev/null)
		if [[ "$country" = "" ]]
		then
			country=""$RS"Not found"$CE""
		fi
		loc=$(curl ipinfo.io/"$A1"/loc 2>/dev/null)
		if [[ "$loc" = "" ]]
		then
			locbool=0
			loc=""$RS"Not found"$CE""
		fi
		city=$(curl ipinfo.io/"$A1"/city 2>/dev/null)
		if [[ "$city" = "" ]]
		then
			city=""$RS"Not found"$CE""
		fi
		org=$(curl ipinfo.io/"$A1"/org 2>/dev/null)
		if [[ "$org" = "" ]]
		then
			org=""$RS"Not found"$CE""
		fi
		postal=$(curl ipinfo.io/"$A1"/postal 2>/dev/null)
		if [[ "$postal" = "" ]]
		then
			postal=""$RS"Not found"$CE""
		fi
		region=$(curl ipinfo.io/"$A1"/region 2>/dev/null)
		if [[ "$region" = "" ]]
		then
			region=""$RS"Not found"$CE""
		fi
		hostname=$(curl ipinfo.io/"$A1"/hostname 2>/dev/null)
		if [[ "$hostname" = "" ]]
		then
			hostname=""$RS"Not found"$CE""
		fi
		echo -e "     Country: $country"
		echo -e "      Region: $region"
		echo -e "    Location: $loc"
		echo -e "        City: $city"
		echo -e "      Postal: $postal"
		echo -e "    Hostname: $hostname"
		echo -e "Organization: $org"
		if [[ "$locbool" = 0 ]]
		then
			echo -e ""$RS" m"$CE") Open google maps location"
		else
			echo -e ""$YS" m"$CE") Open google maps location"
		fi
		echo -e ""$YS" x"$CE") Exit"
		echo -e "Choose: "
		read ge
		if [[ "$ge" = "m" ]]
		then
			if [[ "$locbool" = 0 ]]
			then
				echo -e ""$RS"Location was not found"$CE""
				sleep 3
			else
				gio open https://www.google.gr/maps/search/"$loc"/
				exit
			fi
		else
			clear
			exit
		fi
	else
		echo 0
	fi
}

function is_it_an_ip()
{
	IIA=$1
	IIAI=${#IIA}
	if [[ "$IIA" = "" ]]
	then
		echo -e ""$RS"Error 9. No parameteres passed"
		sleep 2
	else
		if [[ "$IIAI" -le 15 && "$IIAI" -ge 7 ]]
		then
			echo 1
		else
			echo 0
		fi
	fi
}

function get_ip() 
{
  IPG=$(zenity --title="☢ SET IP ☢" --text "Your-Public-ip: $publicip" --entry-text "$publicip" --entry --width 300 2> /dev/null)
}

function exec()
{
	geolocate_ip "$IPG"
}

checkinternet
depend
start=$(zenity --question --title="☢ Evil-Droid Framework ☢" --text "Execute framework and Services?" --width 270 2> /dev/null)
  if [ "$?" -eq "0" ];
  then
      clear
      sleep 2
      banner
      get_ip
      exec
  else
      exit
  fi
    
