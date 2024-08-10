#! /bin/bash

function instalar_basico() {
    local paquetes=("curl" "git" "neofetch" "htop" "vlc" "thonny")

    for pack in "${paquetes[@]}"
    do
        if dpkg -s "$pack" &> /dev/null; then
            echo "$pack ya está instalado."
        else
            echo "Instalando $pack ..."
            sudo apt install -y "$pack"
        fi
    done
}

function f_c(){
	sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev pkg-config
	}
function f_java(){
	sudo apt install openjdk-17-jdk
	}
function f_python(){
	sudo apt install python3-all-dev python3-pip python3-psutil python3-twisted stress python3-setuptools python3-pyqt5 python3-pip
	sudo apt install python3-tk
	sudo apt-get install python3-pygame
	sudo apt install python3-wxgtk4.0
	}
	
function instalar_programacion() {
    local opp

    while true; do
        echo "LENGUAJES DISPONIBLES: "
        echo "1- C/C++"
        echo "2- Java"
        echo "3- Python"
        echo "4- ALL"
        echo "5- Salir"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) f_c ;;
            2) f_java ;;
            3) f_python ;;
            4) 
                f_c;
                f_java;
                f_python;
                ;;
            5)
                echo "Saliendo del programa."
                break
                ;;
            *)
                echo "Opción inválida. Por favor, selecciona una opción válida."
                ;;
        esac

        echo "Presiona Enter para volver al menú..."
        read  # Pausa 
    done
}

