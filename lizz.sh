source ./.system/modules/system/system.sh
source ./.system/modules/drivers/drivers.sh

#dependency
! command -v dialog &> /dev/null && INSTALL_PACKAGE dialog "sudo apt-get install dialog"

if [[ ! -f  $HOME/.fonts/lizz.cache ]]
then
	#dependency
	! command -v wget &> /dev/null && INSTALL_PACKAGE wget "sudo apt-get install wget"

	#dependency
	[[ ! -f ./cache/3270/3270.zip ]] && INSTALL_PACKAGE 3270_1 \
	"wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip -P ./cache/3270"
	INSTALL_PACKAGE 3270_2 \
		"unzip ./cache/3270/3270.zip -d $HOME/.fonts && touch $HOME/.fonts/lizz.cache && fc-cache -fv"
fi

LIZZ_MENU
