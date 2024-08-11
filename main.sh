#! /bin/bash

source gestor_pack.sh
source install_pack.sh

function gatito(){
	echo " _._     _,-'""'-._"
	echo "(,-.'._,'(       |\`-/|"
	echo "    '-.-' \ )-'( , o o)"
	echo "          '-    \'_'´\_"
	echo -e "\n\n"
	}

function gatito2(){
	echo "      |\      _,,,---,,_"
	echo "ZZZzz /,'.-''    -.  ;-;;,"
	echo "     |,4-  ) )-,_. ,\ (  ''-'"
	echo "    '---''(_/--'  '-'\_) "
	echo -e "\n\n"
	}

function permisos(){
	chmod +x gestor_pack.sh install_pack.sh
	}

function version(){
	echo "Version 0.2"
	echo -e "Realizado por p3p3_p4k4z ^^\n"
	gatito2
	}

function help(){
	echo "Por el momento no hay parametros :/"
}

function requisito(){
	local pack=("nala")
	if dpkg -s "$pack" &> /dev/null; then
		echo "Iniciando en breve..."
		sleep 3
	else
		echo "Instalando $pack ..."
		echo "Este paquete es necesario para usar el programa"
		sudo apt install -y "$pack"
	fi
}

function nueva_pc(){
	clear;
	echo "Bienvenid@ a tu nueva pc... Se comenzara a instalar todo lo neceseria"
	gatito
	echo -e "Se paciente y por favor espera\n\n"
	actualizar_pack;
	echo -e "\n Se comenzara a instalar todo lo necesario\n\n"
	instalar_basico;
	echo -e "\n Se comenzara a instalar herramientas de programacion\n\n"
	f_c;f_java;f_python;
	sudo nala install geany thonny

	echo -e "\n\nTU NUEVA PC YA ESTA LISTA PARA USAR :^)\n\n"
	gatito2
	
	}
function menu_pack() {
    while true; do
        echo -e "\n\nMenú de Gestión de Paquetes:"
        echo "1- Actualizar Paquetes"
        echo "2- Buscar un Paquete"
        echo "3- Eliminar un Paquete"
        echo "4- Limpiar Paquetes del Sistema"
        echo "5- Regresar al menu principal"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) actualizar_pack;;
            2) buscar_pack ;;
            3) eliminar_pack ;;
            4) limpiar_pack ;;
            5) echo "Regresando..."; break ;;
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
            4) break;;
            5) echo "Regresando..."; break ;;
            *) echo "Opción inválida. Por favor, selecciona una opción válida." ;;
        esac

        echo "Presiona Enter para volver al MENU PRINCIPAL..."
        read
    done
}

#main

permisos
requisito
clear

#saber si somos su
if [ "$(id -u)" == "0" ];then
	while true; do
	nombre=$(whoami)
	echo -e "\t\t\tBienvenido accediste como: $nombre"
	echo -e "\t\t\tEste es un pequeño asistente para el sistema Debian 12"
	gatito
	
	echo "1- Inicio basico para nueva pc"
	echo "2- Gestor de paquetes"
	echo "3- Instalar paquetes"
	echo "4- Ayuda y Orientacion"
	echo "5- Salir"

	echo "Teclea una opcion"
	read op
	
	case $op in
		1) nueva_pc;;
		2) menu_pack;;
		3) menu_instalar;;
		4) echo -e "En desarrollo...\n\n"; read;;
		5) exit 0;;
		*)
			echo -e "No seleccionaste nada...\n\n";;
	esac
    done
else
	echo -e "\n\nPor favor reinicia el programa y inicia como superusuario..."
	sleep 5
	exit 0
fi		
