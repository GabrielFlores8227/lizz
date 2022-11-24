#---CHECKERS---------------------------------------------------------------------------------
function DEPENDENCY_CHECKER_T() {
	command -v $1 &> /dev/null
	if [ $? -eq 1 ]
	then
		echo -e "\033[1;32m[#] Installing $1\033[0m"
		eval $2
	fi
}

function PACKAGE_CHECKER_T() {
	command -v $1 &> /dev/null
	if [ $? -eq 1 ]
	then
		echo -e "\033[1;32m[#] Installing $1\033[0m"
		eval $2 \
		&& echo -e "\033[1;32m[#] $1 installed\033[0m" \
		&& echo -ne "\n\033[0;37;42mPRESS ENTER TO CONTINUE\033[0m" && read -sp "" \
		|| echo -ne "\n\033[0;37;41mPRESS ENTER TO CONTINUE\033[0m" && read -sp ""
	else
		echo -e "\033[1;32m[#] $1 is already installed\033[0m"
		echo -ne "\n\033[0;37;42mPRESS ENTER TO CONTINUE\033[0m" && read -sp ""
	fi
}

#---MENUS---------------------------------------------------------------------------------

function PROGRAMMING_LANGUAGE_MENU() {
	DEPENDENCY_CHECKER_T dialog "sudo apt-get install dialog -y" || exit 1

	MENU=$(
	dialog --menu "Programming Languages" 20 75 15 \
	1 "Node.js | source: https://deb.nodesource.com/setup_19.x" \
	2 "Python3 | source: python3-defaults" \
	x "< Back" --stdout
	)

	case $MENU in
		1)
			clear
			NODE_DRIVER && PROGRAMMING_LANGUAGE_MENU
			;;
		2)
			clear
			PYTHON_DRIVER && PROGRAMMING_LANGUAGE_MENU
			;;
		x)
			LIZZ_MENU
			;;
		*)
			LIZZ_MENU
			;;
	esac
}

function LIZZ_MENU() {
	DEPENDENCY_CHECKER_T dialog "sudo apt-get install dialog -y" || exit 1

	MENU=$(
	dialog --menu "Welcome to Liss" 20 35 15 \
	1 "Programming Languages" \
	2 "Programs and Packages" \
	x "< Quit" --stdout
	)

	case $MENU in
		1)
			PROGRAMMING_LANGUAGE_MENU
			;;
		x)
			clear && exit
			;;
		*)
			clear && exit
			;;
	esac
}

trap 'clear && exit' SIGINT
