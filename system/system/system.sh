#---drivers-----------------------------------------------------------------------------------------
#mysql drivers
function MYSQL_DRIVER() {
	! dpkg -s mecab-ipadic-utf8 &> /dev/null && INSTALL_PACKAGE mecab-ipadic-utf8 "sudo apt-get install mecab-ipadic-utf8"

	if ! dpkg -s libssl1.1 &> /dev/null
	then
		[[ ! -f ./system/cache/mysql/libssl1.1_1.1.1f-1ubuntu2_amd64.deb ]] \
		&& wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -P ./system/cache/mysql
		INSTALL_PACKAGE libssl1.1 "sudo dpkg -i ./system/cache/mysql/libssl1.1_1.1.1f-1ubuntu2_amd64.deb"
	fi

	! dpkg -s gnupg &> /dev/null && INSTALL_PACKAGE "sudo apt-get install gnupg" 

	! command -v wget &> /dev/null && INSTALL_PACKAGE gnupg "sudo apt-get install wget" 
	INSTALL_PACKAGE mysql "wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -P /tmp && sudo dpkg -i /tmp/mysql-apt-config*; sudo apt update && sudo apt install mysql-server"
}

#node drivers
function NODE_DRIVER() {
	! command -v curl &> /dev/null && INSTALL_PACKAGE curl "sudo apt-get install curl" 
	INSTALL_PACKAGE node "curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs"
}

function PYTHON_DRIVER() {
	INSTALL_PACKAGE python3 "sudo apt-get install python3 python3-pip"
}

function INSTALL_DRIVER() {
	if ! command -v $1 &> /dev/null
	then
		$2
	else
		dialog --title "warning" --yesno "$1 is already installed, do you want to reinstall it?" 0 0
		if [ $? -eq 0 ]
		then
			$2
		fi
	fi
	PROGRAMMING_LANGUAGE_MENU
}

#---util-------------------------------------------------------------------------------------------
function INSTALL_PACKAGE() {
	clear && echo -e "\033[1;32m[#] Installing $1\033[0m"
	sudo apt-get update && eval $2 \
	&& echo -e "\n\033[0;37;42mPRESS ENTER TO CONTINUE\033[0m" && read -sp "" \
	|| echo -e "\n\033[0;37;41mPRESS ENTER TO CONTINUE\033[0m" && read -sp ""
}

function PROGRAMMING_LANGUAGE_MENU() {
	MENU=$(
	dialog --menu "Programming Languages" 0 0 0 \
	1 "Mysql   | source: https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb" \
	2 "Node.js | source: https://deb.nodesource.com/setup_19.x" \
	3 "Python3 | source: python3-defaults" \
	x "< Back" --stdout
	)

	case $MENU in
		1)
			INSTALL_DRIVER mysql MYSQL_DRIVER
			;;
		2)
			INSTALL_DRIVER node NODE_DRIVER
			;;
		3)
			INSTALL_DRIVER python3 PYTHON_DRIVER
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
	dialog --menu "Welcome to Lizz" 0 0 0 \
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
