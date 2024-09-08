#!/bin/bash

# Define color codes
r="\033[1;91m"
g="\033[1;92m"
b="\033[1;96m"
y="\033[1;93m"
w="\033[1;97m"
re="\033[1;0m"

_VERS="1.0"
dumb=0

banner() {
    clear && sleep 0.8

    echo -e " _   _ ___  __    ____  _____ _____ _   _ ____  "
    echo -e "| \ | (_) \/ /   / ___|| ____|_   _| | | |  _ \ "
    echo -e "|  \| | |\  /____\___ \|  _|   | | | | | | |_) |"
    echo -e "| |\  | |/  \_____|__) | |___  | | | |_| |  __/ "
    echo -e "|_| \_|_/_/\_\   |____/|_____| |_|  \___/|_|    "
    echo -e ""
    echo -e "                                            ${y}$_VERS"
    echo -e $r"               Author >> ${w}Nix\n"
}

checking() {
    banner
    check_os
    if ! [ -x "$(command -v figlet)" ] || ! [ -x "$(command -v lolcat)" ]; then
        echo -e "        ${b}Figlet....................${r}[${y}☓${r}]"
        sleep 0.8
        echo -e "        ${b}Lolcat....................${r}[${y}☓${r}]"
        sleep 0.8
    else
        echo -e "        ${b}Figlet....................${r}[${g}✓${r}]"
        sleep 0.8
        echo -e "        ${b}Lolcat....................${r}[${g}✓${r}]"
        sleep 0.8
    fi

    if ! [ -x "$(command -v python)" ] || ! [ -x "$(command -v wget)" ]; then
        echo -e "        ${b}Python....................${r}[${y}☓${r}]"
        sleep 0.8
        echo -e "        ${b}Wget......................${r}[${y}☓${r}]"
        sleep 0.8
    else
        echo -e "        ${b}Python....................${r}[${g}✓${r}]"
        sleep 0.8
        echo -e "        ${b}Wget......................${r}[${g}✓${r}]"
        sleep 0.8
    fi

    if ! [ -x "$(command -v git)" ] || ! [ -x "$(command -v nmap)" ]; then
        echo -e "        ${b}Git.......................${r}[${y}☓${r}]"
        sleep 0.8
        echo -e "        ${b}Nmap.....................${r}[${y}☓${r}]"
        sleep 0.8
    else
        echo -e "        ${b}Git.......................${r}[${g}✓${r}]"
        sleep 0.8
        echo -e "        ${b}Nmap......................${r}[${g}✓${r}]"
        sleep 0.8
    fi

    if ! [ -x "$(command -v host)" ] && [ -x "$(command -v whois)" ]; then

	echo -e "        ${b}Host......................${r}[${y}☓${r}]"
	sleep 0.8
	echo -e "        ${b}Whois......................${r}[${y}☓${r}]"
	sleep 0.8

	else

	echo -e "        ${b}Host......................${r}[${g}✓${r}]"
	sleep 0.8
	echo -e "        ${b}Whois.....................${r}[${g}✓${r}]"
	sleep 0.8

    fi
    
    if ! [ -x "$(command -v ifconfig)" ] && [ -x "$(command -v proot)" ]; then

	echo -e "        ${b}Ifconfig...................${r}[${y}☓${r}]"
	sleep 0.8
	echo -e "        ${b}Proot.....................${r}[${y}☓${r}]"
	sleep 0.8

	else

	echo -e "        ${b}Ifconfig..................${r}[${g}✓${r}]"
	sleep 0.8
	echo -e "        ${b}Proot....................${r}[${g}✓${r}]"
	sleep 0.8

    fi    

    if ! [ -d "/$HOME/storage" ] || ! [ -f "$(command -v nethunter)" ]; then
        echo -e "        ${b}Storage Dir...............${r}[${y}☓${r}]"
        sleep 0.8
        echo -e "        ${b}Nethunter.................${r}[${y}☓${r}]\n"
        sleep 0.8
        
        main 
        
    else
        echo -e "        ${b}Storage Dir...............${r}[${g}✓${r}]"
        sleep 0.8
        echo -e "        ${b}Nethunter.................${r}[${g}✓${r}]\n"
        sleep 0.8
        
        main
    fi
}

check_os() {
    # Detect if it's Kali Linux or Termux (Android)
    if [ -f /etc/os-release ]; then
        if grep -q "Kali" /etc/os-release; then
            echo -e "${y}       OS Status: ${g}Kali Linux detected.${re}\n"
        else
            echo -e "${r}Unknown Linux distribution.${re}\n"
        fi
    elif [ -d "$PREFIX" ]; then
        echo -e "${y}          OS Status: ${g}Termux (Android) detected.${re}\n"
    else
        echo -e "${r}OS not recognized.${re}\n"
    fi
}

main() {

    read -p "$(echo -e ${b}"Do you want to install packages? ${r}(${g}y${w}/${y}n${r}) ${g}>> ${w}")" opt

    case $opt in
	y)
    	if [ -f /etc/os-release ]; then
        	if grep -q "Kali" /etc/os-release; then
            
            # Install packages for Kali Linux
            		apt update && apt full-upgrade -y
            		apt install -y kali-tools-* python3 wget curl perl axel tor php apache2 nmap dnsutils coreutils golang clang figlet toilet neofetch crunch
            		pip install bs4 requests lolcat cowsay dnspython python-nmap python-whois tornet sqlmap termcolor colored

        	elif [ -d "$PREFIX" ]; then
            
            # Install packages for Android (Termux)
            		apt update && apt full-upgrade -y
            		apt install -y python3 wget curl perl axel tor php apache2 nmap dnsutils coreutils golang clang figlet toilet neofetch phroot crunch
            		pip install bs4 requests lolcat cowsay dnspython python-nmap python-whois tornet sqlmap termcolor colored
            		wget -O nethunter https://offs.ec/2MceZWr
            		chmod +x nethunter
            
            # Prompt to create storage folder in Android
            		read -p "Do you want to create storage folder? [y/n] >> " strd
            		if [[ $strd == "y" ]] || [[ $strd == "Y" ]]; then
                		termux-setup-storage
                		bash nethunter
                		clear
                		echo -e $w"Installation Completed!!\n"
            		elif [[ $strd == "n" ]] || [[ $strd == "N" ]]; then
                		clear
                		echo -e $w"Installation Completed!!\n"
            		else
                		main
            		fi
        else
            echo -e $r"Unsupported OS detected. Exiting...\n"
            exit 1
        fi
    else

    	apt update && apt full-upgrade -y
        apt install -y python3 wget curl perl axel tor php apache2 nmap dnsutils coreutils golang clang figlet toilet neofetch proot crunch
        pip install bs4 requests lolcat cowsay dnspython python-nmap python-whois tornet sqlmap termcolor colored
        wget -O nethunter https://offs.ec/2MceZWr
        chmod +x nethunter
            
        # Prompt to create storage folder in Android
        read -p "Do you want to create storage folder? [y/n] >> " strd
        if [[ $strd == "y" ]] || [[ $strd == "Y" ]]; then
                termux-setup-storage
                bash nethunter
                clear
                echo -e $w"Installation Completed!!\n"
        elif [[ $strd == "n" ]] || [[ $strd == "N" ]]; then
                clear
                echo -e $w"Installation Completed!!\n"
        else
                main
        fi



    fi  # <--- This closing 'fi' was missing
    ;;

            
        n)
            echo -e $y"HAPPY CODING DAY BOIS :D\n"
            exit
            ;;
        *)
            sleep 0.5
            ((dumb++))

            if [ $dumb -eq 3 ]; then
            
                clear
                echo -e $r"ARE YOU STUPID OR SOMETHING? GO AWAY KID YOU ARE NOT PENTESTER\nYOU ARE JUST SCRIPT KIDDIEZ\n"
                exit
            elif [ $dumb -eq 1 ]; then
            
                clear
                echo -e $y"Command invalid, Please type y or n to continue\n"
                sleep 0.8
                main
            elif [ $dumb -eq 2 ]; then
            
                clear
                echo -e $y"I said type y or n to continue.\n"
                sleep 0.8
                main
            fi
            ;;
    esac
}

checking
