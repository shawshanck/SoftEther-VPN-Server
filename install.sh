#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color
myIP="$(dig +short myip.opendns.com @resolver1.opendns.com)"

installApps()
{
    clear
    OS="$REPLY" ## <-- This $REPLY is about OS Selection
    echo -e "You can Install ${GREEN}SoftEther VPN Server${NC} with this script!${NC}"
    echo -e "Please select ${GREEN}'y'${NC} for each item you would like to install."
    echo -e "${RED}NOTE:${NC} Without Docker and Docker-Compose, you cannot install this container.${NC}"
    echo -e ""
    echo -e "To install Docker and Docker-Compose, use the link below:"
    echo -e "${BLUE}https://github.com/shawshanck/Docker-and-Docker-Compose${NC}"
    echo -e ""
    echo -e "${RED}NOTE:${NC} This installation uses ports: ${GREEN}443 992 1194 5443 5555 8888 55555.${NC}"
    echo -e ""
    echo -e ""
    echo -e "      ${CYAN}Provided to you by ${YELLOW}Mohammad Mohammadpour${NC}"
    echo -e "          ${YELLOW}https://github.com/shawshanck${NC}"
    echo -e ""
    
    ISACT=$( (sudo systemctl is-active docker ) 2>&1 )
    ISCOMP=$( (docker-compose -v ) 2>&1 )

    #### Try to check whether docker is installed and running - don't prompt if it is
    
    read -rp "SoftEther VPN Server (y/n): " SVS

    startInstall
}

startInstall() 
{
    clear
    echo -e "*******************************************************"
    echo -e "***         Preparing for Installation              ***"
    echo -e "*******************************************************"
    echo -e ""
    sleep 3s


    if [[ "$SVS" == [yY] ]]; then
        echo -e "*******************************************************"
        echo -e "***         Install SoftEther VPN Server            ***"
        echo -e "*******************************************************"
    
        # pull a softether vpn server docker-compose file from github
        echo -e "${MAGENTA}      1.${NC}${GREEN} Clonning files from Github.${NC}"

        mkdir docker -p && cd docker
        git clone https://github.com/shawshanck/SoftEther-VPS-Server.git
        cd SoftEther-VPN-Server

        echo -e "${MAGENTA}      2.${NC}${GREEN} Running the docker-compose.yml to install and start SoftEther VPN Server.${NC}"
        echo ""
        echo ""

          docker-compose up -d
          sudo docker-compose up -d

        echo -e "${MAGENTA}      3.${NC}${GREEN} Installation completed.${NC}"
        echo -e ""
        echo -e "      Now download and install ${GREEN}SoftEther Server Manager ${NC}from the link below:"
        echo -e "${BLUE}      https://www.softether-download.com/en.aspx?product=softether${NC}"
        echo -e ""
        echo -e ""
        echo -e "      After installation of SoftEther Server Manager successfully completed:"
        echo -e "${GREEN}        1- Create a new setting"
        echo -e "${GREEN}        2- Enter your server/machine IP address in "Host Name""
        echo -e "${GREEN}        3- Select your preferred port. Default is 443"
        echo -e "${GREEN}        4- Click on OK"
        echo -e "${GREEN}        5- Now Connect and do the configurations"
        echo -e "${GREEN}        6- For further tutorials and guides please visit the page below:"
        echo -e "${BLUE}        https://github.com/shawshanck/SoftEther-VPS-Server"
        echo -e ""
        echo -e ""
        echo -e "      ${CYAN}Provided to you by ${YELLOW}Mohammad Mohammadpour${NC}"
        echo -e "          ${YELLOW}https://github.com/shawshanck${NC}"
        echo -e ""
        cd
    fi
    
    exit 1
}

echo ""
echo ""

clear

echo -e "${YELLOW}Let's figure out which OS / Distro you are running.${NC}"
echo -e ""
echo -e ""
echo -e "${GREEN}    From some basic information on your system, you appear to be running: ${NC}"
echo -e "${GREEN}        --  OS Name            ${NC}" $(lsb_release -i)
echo -e "${GREEN}        --  Description        ${NC}" $(lsb_release -d)
echo -e "${GREEN}        --  OS Version         ${NC}" $(lsb_release -r)
echo -e "${GREEN}        --  Code Name          ${NC}" $(lsb_release -c)
echo -e ""
echo -e "${YELLOW}------------------------------------------------${NC}"
echo -e ""

PS3="Please enter 1 to Install SoftEther VPN Server or 2 to exit setup: "
select _ in \
    "Install SoftEther VPN Server" \
    "Exit"
do
  case $REPLY in
    1) installApps ;;
    2) exit ;;
    *) echo "Invalid selection, please try again..." ;;
  esac
done
