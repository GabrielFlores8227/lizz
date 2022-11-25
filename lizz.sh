#!/bin/bash
source ./system/system/system.sh

if ! command -v dialog &> /dev/null
then
	INSTALL_PACKAGE dialog "sudo apt-get install dialog"
fi

LIZZ_MENU

