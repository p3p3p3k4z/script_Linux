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

