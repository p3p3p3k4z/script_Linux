#! /bin/bash

source decorador.sh
source gestor_pack.sh
source install_pack.sh

function permisos(){
	chmod +x gestor_pack.sh install_pack.sh
	}

function version(){
	echo -e "\t\t\tVersion 1.1"
	echo -e "\t\t\tRealizado por p3p3_p4k4z ^^\n"
	gatito2
	}

function ctrl_c() {
    echo -e "\n${colorRojo}¡Operación interrumpida!${finColor}"
    echo -e "Si existio algun error, reportarlo o reinicia...\n"
    gatito2
    exit 1
}

function nueva_pc(){
	clear;
	echo -e "${colorVerde}Bienvenid@ a tu nueva pc... Se comenzara a instalar todo lo neceseria${finColor}"
	echo -e "\n"
	echo -e "\n\nAlgunas veces los paquetes requieren reiniciar\n"
	echo -e "Reinicia tu pc en caso de que lo requiera\n"
	gatito
	sleep 2
	
	divisor2
	echo -e "\t\t\t${colorAzul}Se actualizara el sistema <:3${finColor}"
	sudo apt update && sudo apt upgrade
	divisor2
	actualizar_pack;

	divisor2
	echo -e "\t\t${colorAzul}Se comenzara a instalar todo lo necesario${finColor}"
	divisor2
	gatitoMedio
	instalar_basico;

	divisor2
	echo -e "\t${colorAzul}  Se comenzara a instalar herramientas de programacion${finColor}"
	divisor2
	f_c;f_java;f_python;
	sudo apt install geany thonny -y

	divisor
	echo -e "${colorVerde}TU NUEVA PC YA ESTA LISTA PARA USAR :^)${finColor}"
	echo -e "${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
	gatitoFin2
	read
	}

# parametros
# Función para mostrar la ayuda
mostrar_ayuda() {
  echo "Uso: $0 [opciones]"
  echo ""
  echo "Opciones:"
  echo "  --help        Muestra este mensaje de ayuda"
  echo "  -a [valor]    Opción -a con un valor requerido"
  echo "  -b [valor]    Opción -b con un valor requerido"
  echo "  --version     Muestra la versión del script"
  exit 0
}

# Verificar los argumentos
if [[ "$1" == "--help" ]]; then
  mostrar_ayuda
fi

if [[ "$1" == "--version" ]]; then
  version
fi

# Opciones adicionales
while getopts "a:b:" opt; do
  case $opt in
    a)
      echo "Opción -a con valor $OPTARG"
      ;;
    b)
      echo "Opción -b con valor $OPTARG"
      ;;
    \?)
      echo "Opción inválida: -$OPTARG"
      exit 1
      ;;
  esac
done

# Si no se proporcionan argumentos
#if [ $# -eq 0 ]; then
#  echo "No se han proporcionado opciones. Usa --help para más información."
#fi


#main
trap ctrl_c SIGINT

permisos
requisito
clear

nombre=$(whoami)
echo -e "\t\t\tBienvenido accediste como:${colorRojo} $nombre ${finColor}"
echo -e "\t\t\tEste es un pequeño asistente para el sistema Debian 12"
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
	echo -e "\t\t\t4- Ayuda y Orientacion"
	echo -e "\t\t\t5- Salir"
	divisor
	echo -e "${colorGris}Teclea una opcion${finColor}";read op
	
	case $op in
		1) nueva_pc;;
		2) menu_pack;;
		3) menu_instalar;;
		4)	divisor
			echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"
			divisor
			gatitoFin2
			read
		cat comandos_principales.txt | more
			;;
		5) exit 0;;
		*)
			echo -e "No seleccionaste nada...\n\n";;
	esac
    done
else
	echo -e "${colorAmarillo}\n\nPor favor reinicia el programa y inicia como superusuario...${finColor}"
	sleep 5
	exit 0
fi		
