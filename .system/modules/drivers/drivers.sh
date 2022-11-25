#---programming-languages-drivers---------------------------------------------------
function MYSQL_DRIVER() {
	#dependency
	! command -v wget &> /dev/null && INSTALL_PACKAGE wget "sudo apt-get install wget" 

	#dependency
	! dpkg -s mecab-ipadic-utf8 &> /dev/null && INSTALL_PACKAGE mecab-ipadic-utf8 "sudo apt-get install mecab-ipadic-utf8"

	#dependency
	! dpkg -s gnupg &> /dev/null && INSTALL_PACKAGE gnupg "sudo apt-get install gnupg" 

	#dependency
	if ! dpkg -s libssl1.1 &> /dev/null
	then
		[[ ! -f ./cache/mysql/libssl1/libssl1.1_1.1.1f-1ubuntu2_amd64.deb ]] \
		&& INSTALL_PACKAGE libssl1_1 \
		"wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -P ./cache/mysql/libssl1"
		INSTALL_PACKAGE libssl1_2 "sudo dpkg -i ./cache/mysql/libssl1/libssl1.1_1.1.1f-1ubuntu2_amd64.deb"
	fi

	#mysql
	[[ ! -f ./cache/mysql/mysql-apt-config_0.8.22-1_all.deb ]] \
	&& INSTALL_PACKAGE mysql_1 "wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -P ./cache/mysql"
	INSTALL_PACKAGE mysql_2 "sudo dpkg -i ./cache/mysql/mysql-apt-config*; sudo apt update && sudo apt install mysql-server"
}

function NODE_DRIVER() {
	#dependency
	! command -v curl &> /dev/null && INSTALL_PACKAGE curl "sudo apt-get install curl" 

	#node
	INSTALL_PACKAGE node "curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs"
}

function PYTHON_DRIVER() {
	#python
	INSTALL_PACKAGE python3 "sudo apt-get install python3 python3-pip"
}

function RUST_DRIVER() {
	#dependency
	! command -v curl &> /dev/null && INSTALL_PACKAGE curl "sudo apt-get install curl"

	#dependency
	! dpkg -s build-essential &> /dev/null && INSTALL_PACKAGE build-essential "sudo apt-get install build-essential"

	#dependency
	! command -v gcc &> /dev/null && INSTALL_PACKAGE gcc "sudo apt-get install gcc"

	#dependency
	! dpkg -s make &> /dev/null && INSTALL_PACKAGE make "sudo apt-get install make"

	#rust
	INSTALL_PACKAGE rustc "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && source $HOME/.cargo/env"
}

#---other-packages-drivers----------------------------------------------------------
function NVIM_IDE_DRIVER() {
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

	clear
	
	#dependency
	[[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]] \
	&& INSTALL_PACKAGE vim-plug "sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"

	#nvim ide
	[[ ! -f ./cache/nvim-ide/init.vim ]] \
	&&  INSTALL_PACKAGE nvim-ide_1 "git clone https://github.com/GabrielFlores8227/nvim ./cache/nvim-ide/"
	INSTALL_PACKAGE nvim-ide_2 "[[ ! -d $HOME/.config/nvim ]] && mkdir -p $HOME/.config/nvim; cp -i ./cache/nvim-ide/init.vim $HOME/.config/nvim"

	OTHER_PACKAGES_MENU
}

function SYNTH_SHELL_DRIVER() {
	#dependency
	! command -v git &> /dev/null && INSTALL_PACKAGE git "sudo apt-get install git"
	! dpkg -s fonts-powerline &> /dev/null && INSTALL_PACKAGE fonts-powerline "sudo apt install fonts-powerline"

	[[ ! -d ./cache/synth-shell ]] \
	&& INSTALL_PACKAGE synth-shell_1 "git clone --recursive https://github.com/andresgongora/synth-shell.git ./cache/synth-shell && chmod +x ./cache/synth-shell/setup.sh"
	INSTALL_PACKAGE synth_shell_2 "./cache/synth-shell/setup.sh"
	
	OTHER_PACKAGES_MENU
}

function VISUAL_STUDIO_CODE_DRIVER() {
	#dependency
	! command -v wget &> /dev/null && INSTALL_PACKAGE wget "sudo apt-get install wget"

	#visual studio code
	[[ ! -f ./cache/visual-studio-code/code_1.73.1-1667967334_amd64.deb ]] \
	&& INSTALL_PACKAGE visual-studio-code_1 "wget https://az764295.vo.msecnd.net/stable/6261075646f055b99068d3688932416f2346dd3b/code_1.73.1-1667967334_amd64.deb -P ./cache/visual-studio-code"
	INSTALL_PACKAGE visual-studio-code_2 "sudo dpkg -i ./cache/visual-studio-code/code_1.73.1-1667967334_amd64.deb"
}

#---installers----------------------------------------------------------------------
function INSTALL_PACKAGE() {
	clear && echo -e "\033[1;32m[#] Installing $1\033[0m"
	sudo apt-get update && eval $2 \
	&& echo -e "\n\033[0;37;42mPRESS ENTER TO CONTINUE\033[0m" && read -sp "" \
	|| echo -e "\n\033[0;37;41mPRESS ENTER TO CONTINUE\033[0m" && read -sp ""
}

function EXECUTE_DRIVER() {
	if ! command -v $1 &> /dev/null && ! dpkg -s $1 &> /dev/null
	then
		clear && $2
	else
		dialog --title "warning" --yesno "$1 is already installed, do you want to reinstall it?" 0 0
		if [ $? -eq 0 ]
		then
			clear && $2
		fi
	fi
	$3
}
