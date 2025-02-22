#! /bin/bash

source decorador/color.sh
source decorador/dibujo_cafe.sh
source decorador/dibujo_gato.sh
source decorador/separador.sh

source docs/info.sh

source pack/paquetes.sh
source pack/install_pack.sh
source pack/gestor_pack.sh
source pack/menu_pack.sh

function version(){
	echo -e "\t\t\tVersion 2.5"
	echo -e "\t\t\tRealizado por p3p3p4k4z ^^\n"
	gatito2
	}

function ctrl_c() {
    echo -e "\n${colorRojo}¡Operación interrumpida!${finColor}"
    echo -e "Si existio algun error, reportarlo o reinicia...\n"
    gatito2
    exit 1
	}

# parametros
# Función para mostrar la ayuda
mostrar_ayuda() {
  echo "Uso: $0 [opciones]"
  echo ""
  echo "Opciones:"
  echo "  --help        Muestra este mensaje de ayuda"
  echo "  --install		Instala todo lo necesario para una nueva pc"
  echo "  --version     Versión del script"
  exit 0
}

# Verificar los argumentos
if [[ "$1" == "--help" ]]; then
  mostrar_ayuda;
fi

if [[ "$1" == "--version" ]]; then
  version;
fi

if [[ "$1" == "--install" ]]; then
  nueva_pc;
fi

#main
trap ctrl_c SIGINT

permisos
clear

nombre=$(whoami)
echo -e "\t\t\tBienvenido accediste como:${colorRojo} $nombre ${finColor}"
echo -e "\t\t\tEste es un script para gestionar paquetes"
echo -e "\t\t\tcompatible en los sistemas Debian/Ubuntu"
version
echo -e "${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
read

#saber si somos su
if [ "$(id -u)" == "0" ];then
	while true; do
	clear
	divisor
	echo -e "\t\t\t        - - - MENU - - -"
	echo -e "\t\t\t1- Inicio basico para nueva pc"
	echo -e "\t\t\t2- Gestor de paquetes"
	echo -e "\t\t\t3- Instalar paquetes"
	echo -e "\t\t\t4- Instalar Wine"
	echo -e "\t\t\t5- Instalar Docker"
	echo -e "\t\t\t6- Comandos para LINUX"
	echo -e "\t\t\t7- Comandos para GIT"
	echo -e "\t\t\t8- Paquetes flatpack"
	echo -e "\t\t\t9- Escritorio bspwm (SOLO PARA DEBIAN)"
	echo -e "\t\t\t10- Impresora HP"
	echo -e "\t\t\t0- Salir"
	divisor
	echo -e "${colorGris}Teclea una opcion${finColor}";read op
	
	case $op in
		1) nueva_pc;;
		2) menu_pack;;
		3) menu_instalar;;
		4) f_wine;;
		5) f_docker;;
		6)	divisor
			echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"
			divisor
			gatitoFin2
			sleep 3
			leer_comandos;
			;;
		7)	divisor
			echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"
			divisor
			gatitoFin2
			sleep 3
			leer_git;
			;;
		8) f_flatpak;;
		9) bspwm;;
		10)f_impresora_hp;;
		0) exit 0;;
		*)
			echo -e "No seleccionaste nada...\n\n";;
	esac
    done
else
	echo -e "${colorAmarillo}\n\nPor favor reinicia el programa y inicia como superusuario...${finColor}"
	gatitoFin2
	sleep 5
	exit 0
fi		
