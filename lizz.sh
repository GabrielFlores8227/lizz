#!/bin/bash
source ./.system/util/util.sh
source ./.system/menu/menu.sh
source ./.system/drivers/programming_languages_driver.sh

CHECK_PACKAGE dialog "sudo apt-get install dialog"
LIZZ_MENU

