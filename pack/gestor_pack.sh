#! /bin/bash

function actualizar_pack() {
    echo -e "\nActualizando la lista de paquetes..."
    #sudo nala update
    sleep 3
    echo -e "\nActualizando los paquetes instalados..."
    sudo nala upgrade --assume-yes
    echo "Todo listo *<:^)"
}

function buscar_pack() {
    local pack

    echo -e "\nDime el nombre del paquete a buscar en el sistema"
    read pack
    if sudo dpkg-query --list | grep -i "$pack"; then
        echo "Paquete(s) encontrado(s)."
    else
        echo "No se encontraron paquetes con el nombre: $pack"
    fi
}

function buscaronline_pack(){
    local pack opp np 

    echo -e "\nDime el nombre del paquete a buscar en línea"
    read pack

    if nala search "$pack"; then
		divisor2
        echo "¿Deseas conocer más sobre el paquete? (S/s)"
        read opp

        if [[ "$opp" == "S" || "$opp" == "s" || "$opp" == "" ]]; then
            echo "Ingresa el nombre del paquete:"
            read np
            divisor
            nala show "$np"
            divisor
        fi
    else
        echo "No se encontraron paquetes con el nombre: $pack"
    fi
}

function eliminar_pack() {
    local pack confirm

    echo -e "\nDime el nombre del paquete a eliminar"
    read pack
    echo "¿Estás seguro de que deseas eliminar el paquete '$pack'? (s/n)"
    read confirm
    if [[ "$confirm" == "s" || "$confirm" == "S" || "$confirm" == "" ]]; then
        sudo apt remove --purge "$pack"
        echo "Paquete '$pack' eliminado."
    else
        echo "Operación cancelada."
    fi

}

function limpiar_pack() {
    echo "Limpiando paquetes innecesarios..."
    sudo apt autoremove -y
    sudo apt clean
    echo "Sistema limpio."
}

function menu_pack() {
    while true; do
        echo -e "\n\nMenú de Gestión de Paquetes:"
        echo "1- Actualizar Paquetes"
        echo "2- Buscar un Paquete"
        echo "3- Buscar en linea un paquete"
        echo "4- Eliminar un Paquete"
        echo "5- Limpiar Paquetes del Sistema"
        echo "6- Regresar al menu principal"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) actualizar_pack;;
            2) buscar_pack ;;
			3) buscaronline_pack ;;
            4) eliminar_pack ;;
            5) limpiar_pack ;;
            6) echo "Regresando..."; break ;;
            *) echo "Opción inválida. Por favor, selecciona una opción válida." ;;
        esac

        echo "Regresando..."
        read
    done
}
