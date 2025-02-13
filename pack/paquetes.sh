#! /bin/bash

paquete_inicial=("curl" "git" "neofetch" "htop" "gufw" "xinput" "tree" "nala" "aptitude")

function instalar_basico() {
    for pack in "${paquete_inicial[@]}"
    do
        if dpkg -s "$pack" &> /dev/null; then
            echo "$pack ya está instalado."
        else
            echo "Instalando $pack ..."
            sudo apt install -y "$pack"
        fi
    done
}

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
	sudo nala install cbonsai lolcat toilet cowsay fortunes-es cmatrix oneko hollywood --assume-yes
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

#Para wine
function wine_test(){
	local pack=("wine")
	if dpkg -s "$pack" &> /dev/null; then
		echo "Este paquete ya se encuentra en sistema"
		sleep 1
		break
	fi
	}

function f_wine(){
	wine_test
	aptitude_test
	sudo aptitude install wine -y
	echo "Ya puedes usar wine. Solo ejecutalo en tu consola"
	echo "wine app.exe"
	sleep 3
	}

#Para docker
function docker_test(){
	local pack=("docker")
	if dpkg -s "$pack" &> /dev/null; then
		echo "Este paquete ya se encuentra en sistema"
		sleep 1
		break
	fi
	}

function f_docker() {
	docker_test
	aptitude_test

	# Instalar dependencias
	echo "Instalando dependencias necesarias..."
	sudo aptitude install -y apt-transport-https ca-certificates curl software-properties-common

	# Agregar la clave GPG oficial de Docker
	echo "Añadiendo clave GPG de Docker..."
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

	# Agregar el repositorio de Docker
	echo "Añadiendo repositorio de Docker..."
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	# Actualizar paquetes e instalar Docker
	echo "Actualizando repositorios e instalando Docker..."
	sudo apt update
	sudo aptitude install -y docker-ce docker-ce-cli containerd.io

	# Agregar usuario al grupo docker para evitar usar sudo en cada comando
	echo "Añadiendo el usuario actual al grupo docker..."
	sudo usermod -aG docker $USER

	echo "Instalación completada. Para aplicar cambios, cierra sesión o reinicia el sistema."
	echo "Para verificar la instalación, ejecuta: docker --version"
	sleep 3
}

function f_flatpak() {
	aptitude_test

	# Instalar Flatpak
	echo "Instalando Flatpak..."
	sudo aptitude install -y flatpak

	# Agregar el repositorio de Flathub (opcional pero recomendado)
	echo "Añadiendo Flathub como repositorio oficial de Flatpak..."
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	echo "Flatpak ha sido instalado correctamente."
	echo "Para instalar aplicaciones, visita https://flathub.org"
	sleep 3
}

export paquete_inicial