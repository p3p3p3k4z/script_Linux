#! /bin/bash

function requisito(){
	local pack=("nala")
	if dpkg -s "$pack" &> /dev/null; then
		echo "Iniciando en breve..."
		sleep 1
	else
		echo "Instalando $pack ..."
		echo "Este paquete es necesario para usar el programa"
		sudo apt install -y "$pack"
	fi
}

function instalar_basico() {
    local paquetes=("curl" "git" "neofetch" "htop" "vlc" "gufw" )

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
	sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev pkg-config -y
	}
function f_java(){
	sudo apt install openjdk-17-jdk -y
	}
function f_python(){
	sudo apt install python3-all-dev python3-pip python3-psutil python3-twisted stress python3-setuptools python3-pyqt5 python3-pip python3-tk python3-pygame python3-wxgtk4.0 -y
	}
	
function instalar_programacion() {
    local opp

    while true; do
        echo -e "\nLENGUAJES DISPONIBLES: "
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
                echo "Saliendo del menu."
                break
                ;;
            *)
                echo "Opción inválida. Por favor, selecciona una opción válida."
                ;;
        esac

        echo "Regresando.."
        read  
    done
}

function instalar_IDE() {
	local opp
	
    while true; do
        echo -e "\nIDES DISPONIBLES: "
        echo "1- Geany (IDE RECOMENDADO)"
        echo "2- Thonny (IDE PYTHON RECOMENDADO)"
        echo "3- Spider (IDE PYTHON CIENCIA DE DATOS)"
        echo "4- NEOVIM"
        echo "5- Emacs"
        echo "6- Salir"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) sudo nala install geany ;;
            2) sudo nala install thonny ;;
            3) sudo nala install spyder ;;
            4) sudo nala install neovim;;
            5) sudo nala install emacs ;;
            6)
                echo "Saliendo del menu."
                break
                ;;
            *)
                echo "Opción inválida. Por favor, selecciona una opción válida."
                ;;
        esac

        echo "Regresando..."
        read  
    done
	}

function pack_curiosos(){
    while true; do
        echo -e "\nPAQUETES CURIOSOS:"
        echo "1- CBONSAI (Dibujar bonsai desde terminal)"
        echo "2- LOLCAT (Un cat con colores)"
        echo "3- TOILET (Palabra ASCII/Editor)"
        echo "4- COWSAY (Animales dando una frase)"
        echo "5- FORTUNE (Frase de fortuna del dia)"
        echo "6- CMATRIX (Simulador de matrix)"
        echo "7- Regresar al menu principal"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) sudo nala install cbonsai;;
            2) sudo nala install lolcat;;
            3) sudo nala install toilet;;
            4) sudo nala install cowsay;;
            5) sudo nala install fortune;;
            6) sudo nala install cmatrix;;
            5) echo "Saliendo del menu"; break ;;
            *) echo "Opción inválida. Por favor, selecciona una opción válida." ;;
        esac

        echo "Regresando..."
        read
    done
	}

function menu_instalar() {
    while true; do
        echo -e "\n\nMenú de Instalacion de paquetes:"
        echo "1- Paquetes Basicos"
        echo "2- Paquetes de Programacion"
        echo "3- Paquetes de IDE"
        echo "4- Paquetes Curiosos"
        echo "5- Regresar al menu principal"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) instalar_basico;;
            2) instalar_programacion;;
            3) instalar_IDE;;
            4) pack_curiosos;;
            5) echo "Saliendo del menu"; break ;;
            *) echo "Opción inválida. Por favor, selecciona una opción válida." ;;
        esac

        echo "Regresando..."
        read
    done
}
