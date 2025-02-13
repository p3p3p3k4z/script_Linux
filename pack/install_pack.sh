#! /bin/bash

source ./pack/paquetes.sh
source ./pack/gestor_pack.sh

source ./decorador/separador.sh
source ./decorador/color.sh
source ./decorador/dibujo_gato.sh
source ./decorador/dibujo_cafe.sh


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

function permisos(){
	chmod +x *.sh
	}

function nueva_pc(){
	clear;

	echo -e "${colorVerde}Bienvenid@ a tu nueva pc... Se comenzara a instalar todo lo neceseria${finColor}"
	echo -e "\n"
	echo -e "\n\nAlgunas veces los paquetes requieren reiniciar\n"
	echo -e "Reinicia tu pc en caso de que lo requiera\n\n"
	cafe_mensaje
	sleep 2
	
	divisor2
	echo -e "\t\t\t${colorAzul}Se actualizara el sistema <:3${finColor}"
	#sudo apt update && sudo apt upgrade
	actualizar_pack;

	divisor2
	echo -e "\t\t${colorAzul}Se comenzara a instalar todo lo necesario${finColor}"
	gatitoMedio
	instalar_basico;

    divisor2
	echo -e "\t${colorAzul}Se instalara los herramientas de media${finColor}"
    f_media;

	divisor2
	echo -e "\t${colorAzul}  Se comenzara a instalar herramientas de programacion${finColor}"
	f_c;f_java;f_python;
	sudo nala install geany thonny neovim --assume-yes; 

    divisor2
	echo -e "\t${colorAzul}Se instalara chacharas para el sistema${finColor}"
    f_chacharas;

    limpiar_pack;

	divisor
	echo -e "${colorVerde}TU NUEVA PC YA ESTA LISTA PARA USAR :^)${finColor}"
	echo -e "${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
	gatitoFin2
	read
    }
    
function bspwm(){
	echo -e "${colorVerde}ESTE ES UN ENTORNO DE ESCRITORIO Y COMPLEMENTO EXCLUSIVO PARA DEBIAN${finColor}"
	echo -e "\nSi Te equivocaste reinicia el programa\n"
	cafe;
	sudo apt install git inxi -y && cd /tmp && git clone https://github.com/thespation/dpux_bspwm && chmod 755 dpux_bspwm/* -R && cd dpux_bspwm/ && ./instalar.sh
	}
