#!/bin/bash
source ./system/system/system.sh

! command -v dialog &> /dev/null && INSTALL_PACKAGE dialog "sudo apt-get install dialog"
LIZZ_MENU

