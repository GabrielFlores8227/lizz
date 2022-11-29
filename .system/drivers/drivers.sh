function MYSQL_DRIVER() {
	CHECK_PACKAGE wget  "sudo apt-get install wget"
	CHECK_PACKAGE mecab-ipadic-utf8 "sudo apt-get install mecab-ipadic-utf8"
	CHECK_PACKAGE gnupg "sudo apt-get install gnupg"
	CHECK_PACKAGE libssl1.1 "[[ ! -f /tmp/lizz/mysql/libssl1/libssl1.1_1.1.1f-1ubuntu2_amd64.deb ]] && wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -P /tmp/lizz/mysql/libssl1; sudo dpkg -i /tmp/lizz/mysql/libssl1/libssl1.1_1.1.1f-1ubuntu2_amd64.deb"
	CHECK_PACKAGE_D mysql "[[ ! -f /tmp/lizz/mysql/mysql-apt-config_0.8.22-1_all.deb ]] && wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -P /tmp/lizz/mysql; sudo dpkg -i /tmp/lizz/mysql/mysql-apt-config* && sudo apt update && sudo apt install mysql-server"
}

function NODE_DRIVER() {
	CHECK_PACKAGE curl "sudo apt-get install curl"
	CHECK_PACKAGE_D node "curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs"
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

function NVIM_IDE_DRIVER() {
	CHECK_PACKAGE nvim "sudo apt-get install neovim"
	CHECK_PACKAGE node "NODE_DRIVER"
	CHECK_PACKAGE yarn "sudo apt-get install yarn"
	CHECK_PACKAGE python3 "PYTHON3_DRIVER"
	CHECK_PACKAGE unzip "sudo apt-get install unzip"
	CHECK_PACKAGE curl "sudo apt-get install curl"
	CHECK_PACKAGE git "sudo apt-get install git"
	dialog --title "warning" --yesno "Do you want to install font 3270 (recommended)?" 0 0 \
	&& CHECK_PACKAGE_D nerd-fonts "[[ ! -f /tmp/lizz/nvim-ide/nerd-fonts/3270.zip ]] && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip -P /tmp/lizz/nvim-ide/nerd-fonts; unzip /tmp/lizz/nvim-ide/nerd-fonts/3270.zip -d $HOME/.fonts"
	CHECK_PACKAGE_D vim-plug "sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
	CHECK_PACKAGE_D nvim-ide "git clone https://github.com/GabrielFlores8227/nvim $HOME/.config/nvim"
}

function SYNTH_SHELL_DRIVER() {
	CHECK_PACKAGE git "sudo apt-get install git"
	CHECK_PACKAGE fonts-powerline "sudo apt-get install fonts-powerline"
	CHECK_PACKAGE_D synth-shell "[[ ! -f /tmp/lizz/synth-shell/setup.s ]] && git clone --recursive https://github.com/andresgongora/synth-shell.git /tmp/lizz/synth-shell && chmod +x /tmp/lizz/synth-shell/setup.sh; /tmp/lizz/synth-shell/setup.sh"
}
