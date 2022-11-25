#---drivers-----------------------------------------------------------------------------------------
#mysql drivers
function MYSQL_DRIVER() {
	#dependency
	! dpkg -s mecab-ipadic-utf8 &> /dev/null && INSTALL_PACKAGE mecab-ipadic-utf8 "sudo apt-get install mecab-ipadic-utf8"

	#dependency
	if ! dpkg -s libssl1.1 &> /dev/null
	then
		[[ ! -f ./system/cache/mysql/libssl1.1_1.1.1f-1ubuntu2_amd64.deb ]] \
		&& wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -P ./system/cache/mysql
		INSTALL_PACKAGE libssl1.1 "sudo dpkg -i ./system/cache/mysql/libssl1.1_1.1.1f-1ubuntu2_amd64.deb"
	fi
	
	#dependency
	! dpkg -s gnupg &> /dev/null && INSTALL_PACKAGE "sudo apt-get install gnupg" 

	#mysql
	! command -v wget &> /dev/null && INSTALL_PACKAGE gnupg "sudo apt-get install wget" 
	INSTALL_PACKAGE mysql "wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -P /tmp && sudo dpkg -i /tmp/mysql-apt-config*; sudo apt update && sudo apt install mysql-server"
}

#node drivers
function NODE_DRIVER() {
	#dependency
	! command -v curl &> /dev/null && INSTALL_PACKAGE curl "sudo apt-get install curl" 

	#node
	INSTALL_PACKAGE node "curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs"
}

function PYTHON_DRIVER() {
	#python3
	INSTALL_PACKAGE python3 "sudo apt-get install python3 python3-pip"
}

function NVIM_AND_INIT_DRIVER() {
	clear

	#dependency
	! command -v nvim &> /dev/null && INSTALL_PACKAGE neovim "sudo apt-get install neovim"

	#dependency
	! command -v node &> /dev/null && NODE_DRIVER

	#dependency
	! command -v yarn &> /dev/null && INSTALL_PACKAGE yarn "sudo apt-get install yarn"

	#dependency
	! command -v python3 &> /dev/null && PYTHON_DRIVER

	#dependency
	! command -v unzip &> /dev/null && INSTALL_PACKAGE unzip "sudo apt-get install unzip"

	#dependency
	! command -v curl &> /dev/null && INSTALL_PACKAGE curl "sudo apt-get install curl" 

	#dependency
	! command -v git &> /dev/null && INSTALL_PACKAGE git "sudo apt-get install git" 
	
	#dependency
	[[ ! -f  $HOME/.fonts/lizz-cache.txt ]] && [[ ! -f ./system/cache/nvim-and-init/3270/3270.zip ]] && INSTALL_PACKAGE 3270_1 \
	"wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip -P ./system/cache/nvim-and-init/3270"
	[[ ! -f  $HOME/.fonts/lizz-cache.txt ]] && INSTALL_PACKAGE 3270_2 \
	"unzip ./system/cache/nvim-and-init/3270/3270.zip -d $HOME/.fonts && touch $HOME/.fonts/lizz-cache.txt && fc-cache -fv"

	[[ ! -f $HOME/.local/share/nvim/lizz-cache.txt ]] \
	&& INSTALL_PACKAGE vim-plug "sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && touch $HOME/.local/share/nvim/lizz-cache.txt"

	[[ ! -f $HOME/.config/nvim/lizz-cache.txt ]] \
	&& git clone https://github.com/GabrielFlores8227/nvim $HOME/.config/nvim && touch $HOME/.config/nvim/lizz-cache.txt

	PROGRAMS_MENU
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

function PROGRAMS_MENU() {
	MENU=$(
	dialog --menu "Programs" 0 0 0 \
	1 "Nvim & init.vim | source: https://github.com/GabrielFlores8227/nvim" \
	x "< Back" --stdout
	)

	case $MENU in
		1)
			NVIM_AND_INIT_DRIVER
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
	2 "Programs" \
	x "< Quit" --stdout
	)

	case $MENU in
		1)
			PROGRAMMING_LANGUAGE_MENU
			;;
		2)
			PROGRAMS_MENU
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
