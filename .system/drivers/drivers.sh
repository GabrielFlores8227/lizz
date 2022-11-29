function MYSQL_DRIVER() {
	CHECK_PACKAGE wget  "sudo apt-get install wget"
	CHECK_PACKAGE mecab-ipadic-utf8 "sudo apt-get install mecab-ipadic-utf8"
	CHECK_PACKAGE gnupg "sudo apt-get install gnupg"
	CHECK_PACKAGE libssl1.1 "[[ ! -f /tmp/mysql/libssl1/libssl1.1_1.1.1f-1ubuntu2_amd64.deb ]] && wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -P /tmp/mysql/libssl1; sudo dpkg -i /tmp/mysql/libssl1/libssl1.1_1.1.1f-1ubuntu2_amd64.deb"
	CHECK_PACKAGE_D mysql "[[ ! -f /tmp/mysql/mysql-apt-config_0.8.22-1_all.deb ]] && wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -P /tmp/mysql; sudo dpkg -i ./cache/mysql/mysql-apt-config*; sudo apt update && sudo apt install mysql-server"
}
