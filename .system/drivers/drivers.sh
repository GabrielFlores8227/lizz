function GOOGLE_CHROME_DRIVER() {
		CHECK_PACKAGE wget "sudo apt-get install wget"
		TEMP=$(mktemp)
		CHECK_PACKAGE_D google-chrome "wget -O $TEMP 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' \
		&& sudo dpkg -i $TEMP; rm $TEMP"
}

function MYSQL_DRIVER() {
	CHECK_PACKAGE wget "sudo apt-get install wget"

	CHECK_PACKAGE mecab-ipadic-utf8 "sudo apt-get install mecab-ipadic-utf8"

	CHECK_PACKAGE gnupg "sudo apt-get install gnupg"

	TEMP=$(mktemp)
	CHECK_PACKAGE libssl1.1 "wget -O $TEMP http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb \
	&& sudo dpkg -i $TEMP; rm $TEMP"

	TEMP=$(mktemp)
	CHECK_PACKAGE_D mysql "wget -O $TEMP https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb \
	&& sudo dpkg -i $TEMP && sudo apt update && sudo apt install mysql-server; rm $TEMP"
}

function NVIM_IDE_DRIVER() {
	CHECK_PACKAGE nvim "sudo apt-get install neovim"

	CHECK_PACKAGE node "NODE_DRIVER"

	CHECK_PACKAGE yarn "sudo apt-get install yarn"

	CHECK_PACKAGE python3 "PYTHON3_DRIVER"

	CHECK_PACKAGE unzip "sudo apt-get install unzip"

	CHECK_PACKAGE curl "sudo apt-get install curl"

	CHECK_PACKAGE git "sudo apt-get install git"

	TEMP=$(mktemp)
	CHECK_PACKAGE_D nerd-fonts "wget -O $TEMP https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip \
	&& unzip $TEMP -d $HOME/.fonts; rm $TEMP"

	CHECK_PACKAGE_D vim-plug "sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"

	CHECK_PACKAGE_D nvim-ide "git clone https://github.com/GabrielFlores8227/nvim $HOME/.config/nvim"
}

function NODE_DRIVER() {
	CHECK_PACKAGE curl "sudo apt-get install curl"

	CHECK_PACKAGE_D node "curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs"
}

function OPERA_DRIVER() {
	CHECK_PACKAGE curl "sudo apt-get install curl"

	CHECK_PACKAGE wget "sudo apt-get install wget"

	for c in $(curl "https://download3.operacdn.com/pub/opera/desktop/93.0.4585.37/linux/" | grep -i "opera-stable" | tr ">" "\n" | tr "<" "\n" | tr '"' "\n")
	do
		if [[ $c =~ .*"amd64.deb".* ]] && [[ ! $c =~ .*"sha256sum".* ]] 
		then
			URL="https://download3.operacdn.com/pub/opera/desktop/93.0.4585.37/linux/$c"
			break
		fi
 	done

	TEMP=$(mktemp)
	CHECK_PACKAGE_D opera "wget -O $TEMP $URL && sudo dpkg -i $TEMP && sudo apt --fix-broken install; rm $TEMP"
}

function PYTHON3_DRIVER() {
	CHECK_PACKAGE_D python3 "sudo apt-get install python3"

	CHECK_PACKAGE_D python3-pip "sudo apt-get install python3-pip"
}

function RUST_DRIVER() {
	CHECK_PACKAGE curl "sudo apt-get install curl"
	
	CHECK_PACKAGE build-essential "sudo apt-get install build-essential"

	CHECK_PACKAGE gcc "sudo apt-get install gcc"

	CHECK_PACKAGE make "sudo apt-get install make"

	CHECK_PACKAGE_D rustc "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && source $HOME/.cargo/env"
}

function SYNTH_SHELL_DRIVER() {
	CHECK_PACKAGE git "sudo apt-get install git"

	CHECK_PACKAGE fonts-powerline "sudo apt-get install fonts-powerline"

	TEMP=$(mktemp -d )
	CHECK_PACKAGE_D synth-shell "git clone --recursive https://github.com/andresgongora/synth-shell.git $TEMP \
	&& chmod +x $TEMP/setup.sh && $TEMP/setup.sh; sudo rm -r $TEMP"
}
