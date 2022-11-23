#---CHECKERS---------------------------------------------------------------------------------
function DEPENDENCY_CHECKER_T() {
	command -v $1 &> /dev/null
	if [ $? -eq 1 ]
	then
		eval $2 && break
	fi
}

function DEPENDENCY_CHECKER_D() {
	command -v $1 &> /dev/null
	if [ $? -eq 1 ]
	then
		echo 1
	else
		echo 0
	fi
}

#---MENUS---------------------------------------------------------------------------------

function PROGRAMMING_LANGUAGE_MENU() {
	DEPENDENCY_CHECKER_T dialog "sudo apt-get install dialog -y" || exit 1

	MENU=$(
	dialog --menu "Programming Languages" 20 75 15 \
	1 "Node.js | source: https://deb.nodesource.com/setup_19.x" \
	2 "Python3 | source: python3-defaults" \
	x "< Quit" --stdout
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
			clear && exit
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
