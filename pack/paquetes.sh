#! /bin/bash

paquete_inicial=("curl" "git" "neofetch" "htop" "gufw" "xinput" "tree" "nala" "aptitude")

#Lenguajes
function f_c(){
	sudo nala install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev pkg-config --assume-yes
	}
function f_java(){
	sudo nala install openjdk-17-jdk default-jdk --assume-yes
	}
function f_python(){
	sudo nala install python3-all-dev python3-pip python3-psutil python3-twisted stress python3-setuptools python3-pyqt5 python3-pip python3-tk python3-pygame python3-wxgtk4.0 --assume-yes
	}
	
#media
function f_media(){
	sudo aptitude install vlc mpv -y
	}	
	
#Decoradores para pc	
function f_chacharas(){
	sudo nala install cbonsai lolcar toilet cowsay fortune cmatrix oneko holywood --assume-yes
	}

#Para wine
function wine_test(){
	local pack=("wine")
	if dpkg -s "$pack" &> /dev/null; then
		echo "Este paquete ya se encuentra en sistema"
		sleep 1
		break
	fi
	}
function aptitude_test(){
	local pack=("aptitude")
	if dpkg -s "$pack" &> /dev/null; then
		echo "Iniciando en breve..."
		sleep 1
	else
		echo "Instalando $pack ..."
		echo "Este paquete es necesario para usar el programa"
		sudo apt install -y "$pack"
	fi
	}
function f_wine(){
	wine_test
	aptitude_test
	sudo aptitude install wine
	echo "Ya puedes usar wine. Solo ejecutalo en tu consola"
	echo "wine app.exe"
	}
