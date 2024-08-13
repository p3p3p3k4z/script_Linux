#! /bin/bash

finColor="\033[0m\e[0m"
colorVerde="\e[0;32m\033[1m"
colorRojo="\e[0;31m\033[1m"
colorAzul="\e[0;34m\033[1m"
colorAmarillo="\e[0;33m\033[1m"
colorMorado="\e[0;35m\033[1m"
colorTurquesa="\e[0;36m\033[1m"
colorGris="\e[0;37m\033[1m"

function gatito(){
	echo -e "${colorMorado} _._     _,-'""'-._${finColor}"
	echo -e "${colorMorado}(,-.'._,'(       |\`-/|${finColor}"
	echo -e "${colorMorado}    '-.-' \ )-'( , o o)${finColor}"
	echo -e "${colorMorado}          '-    \'_'´\_${finColor}"
	echo -e "\n"
	}

function gatitoFin(){
	echo -e "\t\t\t\t\t\t${colorMorado} _._     _,-'""'-._${finColor}"
	echo -e "\t\t\t\t\t\t${colorMorado}(,-.'._,'(       |\`-/|${finColor}"
	echo -e "\t\t\t\t\t\t${colorMorado}    '-.-' \ )-'( , o o)${finColor}"
	echo -e "\t\t\t\t\t\t${colorMorado}          '-    \'_'´\_${finColor}"
	echo -e "\n"
	}

function gatito2(){
	echo -e "${colorMorado}      |\      _,,,---,,_${finColor}"
	echo -e "${colorMorado}ZZZzz /,'.-''    -.  ;-;;,${finColor}"
	echo -e "${colorMorado}     |,4-  ) )-,_. ,\ (  ''-'${finColor}"
	echo -e "${colorMorado}    '---''(_/--'  '-'\_) ${finColor}"
	echo -e "\n\n"
	}

function gatitoFin2(){
	echo -e "\t\t\t\t\t\t${colorMorado}      |\      _,,,---,,_${finColor}"
	echo -e "\t\t\t\t\t\t${colorMorado}ZZZzz /,'.-''    -.  ;-;;,${finColor}"
	echo -e "\t\t\t\t\t\t${colorMorado}     |,4-  ) )-,_. ,\ (  ''-'${finColor}"
	echo -e "\t\t\t\t\t\t${colorMorado}    '---''(_/--'  '-'\_) ${finColor}"
	echo -e "\n"
	}

function divisor(){
	echo -e "\t********************************************************"
	}

function divisor2(){
	echo -e "\t--------------------------------------------------------"
	}

export finColor colorVerde colorRojo colorAzul colorAmarillo colorMorado colorTurquesa colorGris
