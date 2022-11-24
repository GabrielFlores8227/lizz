function PYTHON_DRIVER() {
	PACKAGE_CHECKER_T python3 "sudo apt-get install python3 && sudo apt-get install python3-pip"
}

function NODE_DRIVER() {
	PACKAGE_CHECKER_T node "curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs"
}

