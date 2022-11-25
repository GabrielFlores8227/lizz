#---dialog-menus--------------------------------------------------------------------
function PROGRAMMING_LANGUAGES_MENU() {
	MENU=$(
	dialog --menu "Programming Languages" 0 0 0 \
	1 " Mysql" \
	2 " Node.js" \
	3 " Python" \
	4 " Rust" \
	x " BACK" --stdout
	)

	case $MENU in
		1)
			EXECUTE_DRIVER mysql MYSQL_DRIVER PROGRAMMING_LANGUAGES_MENU
			;;
		2) 
			EXECUTE_DRIVER node NODE_DRIVER PROGRAMMING_LANGUAGES_MENU
			;;
		3)
			EXECUTE_DRIVER python3 PYTHON_DRIVER PROGRAMMING_LANGUAGES_MENU
			;;
		4)
			EXECUTE_DRIVER rustc RUST_DRIVER PROGRAMMING_LANGUAGES_MENU
			;;
		x)
			PROGRAMMER_PACKAGES_MENU
			;;
		*)
			PROGRAMMER_PACKAGES_MENU
			;;
	esac
}

function OTHER_PACKAGES_MENU() {
	MENU=$(
	dialog --menu "Other Pacakges" 0 0 0 \
	1 " Nvim IDE" \
	2 " Synth-Shell | source " \
	3 " Visual Studio Code" \
	x " BACK" --stdout
	)

	case $MENU in
		1)
			NVIM_IDE_DRIVER
			;;
		2)
			SYNTH_SHELL_DRIVER
			;;
		3)
			EXECUTE_DRIVER code VISUAL_STUDIO_CODE_DRIVER OTHER_PACKAGES_MENU
			;;
		x)
			PROGRAMMER_PACKAGES_MENU
			;;
		*)
			PROGRAMMER_PACKAGES_MENU
			;;
	esac
}

function PROGRAMMER_PACKAGES_MENU() {
	MENU=$(
	dialog --menu "Programmer Packages" 0 0 0 \
	1 " Programming Languages" \
	2 " Other Packages" \
	x " BACK" --stdout
	)

	case $MENU in
		1)
			PROGRAMMING_LANGUAGES_MENU
			;;
		2)
			OTHER_PACKAGES_MENU
			;;
		x)
			LIZZ_MENU
			;;
		*)
			LIZZ_MENU
			;;
	esac
}

function DESKTOP_PACKAGES_MENU() {
	MENU=$(
	dialog --menu "Desktop Packages" 0 0 0 \
	1 " Brave" \
	2 " Google Chrome" \
	3 " Opera" \
	4 " Team Viewer" \
	5 " Visual Studio Code" \
	x " BACK" --stdout
	)

	case $MENU in
		x)
			LIZZ_MENU
			;;
		*)
			LIZZ_MENU
			;;
	esac
}

function LIZZ_MENU() {
	MENU=$(
	dialog --menu " Welcome to Lizz" 0 0 0 \
	1 " Programmer Packages" \
	2 " Desktop Packages" \
	x " QUIT" --stdout
	)

	case $MENU in
		1)
			PROGRAMMER_PACKAGES_MENU
			;;
		2)
			DESKTOP_PACKAGES_MENU
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
