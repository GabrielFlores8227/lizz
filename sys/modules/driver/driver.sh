function PYTHON_DRIVER() {
	[[ ! -f ./sys/cache/programming-languages/python/python.txt ]] \
	&& mkdir -p ./sys/cache/programming-languages/python \
	&& touch ./sys/cache/programming-languages/python/python.txt \
	&& touch ./sys/cache/programming-languages/python/error.txt 

	CHECKER=$(DEPENDENCY_CHECKER_D python3)
	
	if [ $CHECKER = 0 ]
	then
		dialog --msgbox  "✅ Python is already installed" 5 35
	else
		echo "0" | dialog --title "Installing Python" --gauge  "Installing Python..." 5 35 0 \
		&& sudo apt-get update 2> ./sys/cache/programming-languages/python/error.txt 1> ./sys/cache/programming-languages/python/python.txt \
		&& echo "33" | dialog --title "Installing Python" --gauge  "Installing Python..." 5 35 0 \
		&& sudo apt-get install python3 -y 2>> ./sys/cache/programming-languages/python/error.txt 1>> ./sys/cache/programming-languages/python/python.txt \
		&& echo "66" | dialog --title "Installing Python" --gauge ""  5 35 0 \
		&& sudo apt-get install python3-pip -y 2>> ./sys/cache/programming-languages/python/error.txt 1>> ./sys/cache/programming-languages/python/python.txt \
		&& echo "100" | dialog --title "Installing Python" --gauge  "" 5 35 0 \
		&& sleep 2 \
		&& dialog --msgbox  "✅ Python installed" 5 35 \
		|| dialog --msgbox  "❌ $(tail ./sys/cache/programming-languages/python/error.txt)" $(($(wc -l < ./sys/cache/programming-languages/python/error.txt) * 5)) 50
	fi
}

