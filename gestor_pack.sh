#! /bin/bash

function actualizar_pack() {
    echo "Actualizando la lista de paquetes..."
    sudo nala update
    sleep 3
    echo -e "\nActualizando los paquetes instalados..."
    sudo nala upgrade
    echo -e "\nSistema actualizado..."
    echo "Todo listo *<:^)"
}

function buscar_pack() {
    local pack
    echo "Dime el nombre del paquete a buscar en el sistema"
    read pack
    if sudo dpkg-query --list | grep -i "$pack"; then
        echo "Paquete(s) encontrado(s)."
    else
        echo "No se encontraron paquetes con el nombre: $pack"
    fi
}

function buscaronline_pack(){
	local pack
    echo "Dime el nombre del paquete a buscar en linea"
    read pack
    if nala search "$pack"; then
        echo "Paquete(s) encontrado(s)."
    else
        echo "No se encontraron paquetes con el nombre: $pack"
    fi
}
	}

function eliminar_pack() {
    local pack
    echo "Dime el nombre del paquete a eliminar"
    read pack
    echo "¿Estás seguro de que deseas eliminar el paquete '$pack'? (s/n)"
    read confirm
    if [[ "$confirm" == "s" || "$confirm" == "S" ]]; then
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
