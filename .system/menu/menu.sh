function PROGRAMMING_LANGUAGES_MENU() {
	MENU=$(
	dialog --menu "Programming Languages" 0 0 0 \
	1 "➥ Mysql" \
	2 "➥ Node.js" \
	3 "➥ Python3" \
	4 "➥ Rust" \
	x "BACK" --stdout
	)

	case $MENU in
		1)
			EXECUTE_DRIVER mysql MYSQL_DRIVER PROGRAMMING_LANGUAGES_MENU
			;;
		2)
			EXECUTE_DRIVER node NODE_DRIVER PROGRAMMING_LANGUAGES_MENU
			;;
		3)
			EXECUTE_DRIVER python3 PYTHON3_DRIVER PROGRAMMING_LANGUAGES_MENU
			;;
		4)
			EXECUTE_DRIVER rustc RUST_DRIVER PROGRAMMING_LANGUAGES_MENU
			;;
		x)
			DEV_PACKAGES_MENU
			;;
		*)
			DEV_PACKAGES_MENU
			;;
	esac
}


function OTHER_PACKAGES_MENU() {
	MENU=$(
	dialog --menu "Other Pacakges" 0 0 0 \
	1 "➥ Nvim IDE" \
	2 "➥ Synth-Shell" \
	x "BACK" --stdout
	)

	case $MENU in
		1)
			EXECUTE_DRIVER_D NVIM_IDE_DRIVER OTHER_PACKAGES_MENU
			;;
		2) EXECUTE_DRIVER_D SYNTH_SHELL_DRIVER OTHER_PACKAGES_MENU
			;;
		x)
			DEV_PACKAGES_MENU
			;;
		*)
			DEV_PACKAGES_MENU
			;;
	esac
}

function DEV_PACKAGES_MENU() {
	MENU=$(
	dialog --menu "Programmer Packages" 0 0 0 \
	1 "➥ Programming Languages" \
	2 "➥ Other Packages" \
	x "BACK" --stdout
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

function LIZZ_MENU() {
	MENU=$(
	dialog --menu "WELCOME TO LIZZ" 0 0 0 \
	1 "➥ Dev Packages" \
	x "QUIT" --stdout
	)

	case $MENU in
		1)
			DEV_PACKAGES_MENU
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
