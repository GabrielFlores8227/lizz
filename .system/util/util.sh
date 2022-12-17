function EXECUTE_DRIVER_D() {
	dialog --title "warning" --yesno "Do you want to install $1?" 0 0 && $2
	$3
}

function CHECK_PACKAGE() {
	if ! command -v $1 &> /dev/null && ! dpkg -s $1 &> /dev/null 
	then
		CHECK_PACKAGE_D $@
	fi
}

function CHECK_PACKAGE_D() {
	clear && echo -e "\n\033[1;32m[*] Installing $1\033[m" \
	&& sudo apt-get update && eval $2 \
	&& echo -e "\n\033[0;37;42m$1 installed | PRESS ENTER TO CONTINUE\033[0m" && read -sp "" \
	|| echo -e "\n\033[0;37;41m$1 could not be installed | PRESS ENTER TO CONTINUE\033[0m" && read -sp ""
}

