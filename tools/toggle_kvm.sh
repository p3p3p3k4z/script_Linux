#!/bin/bash

KVM_BLACKLIST_FILE="/etc/modprobe.d/blacklist-kvm.conf"
KVM_MODULES_COMMON="kvm"
KVM_MODULE_INTEL="kvm_intel"
KVM_MODULE_AMD="kvm_amd"

# Determine CPU type
if grep -q "vendor_id.*GenuineIntel" /proc/cpuinfo; then
    CPU_TYPE="Intel"
    KVM_MODULE_SPECIFIC="$KVM_MODULE_INTEL"
elif grep -q "vendor_id.*AuthenticAMD" /proc/cpuinfo; then
    CPU_TYPE="AMD"
    KVM_MODULE_SPECIFIC="$KVM_MODULE_AMD"
else
    CPU_TYPE="Unknown"
    echo "Advertencia: No se pudo determinar el tipo de CPU (Intel/AMD). Usaremos módulos genéricos."
    KVM_MODULE_SPECIFIC="" # No specific module if unknown
fi

echo "Tipo de CPU detectado: $CPU_TYPE"

# Function to update initramfs based on available commands
update_initramfs_command() {
    echo "Actualizando initramfs. Esto puede tomar un momento..."
    if command -v dracut &> /dev/null; then
        echo "Usando dracut -f..."
        sudo dracut -f
    elif command -v update-initramfs &> /dev/null; then
        echo "Usando update-initramfs -u..."
        sudo update-initramfs -u
    else
        echo "Error: No se encontró 'dracut' ni 'update-initramfs'. No se pudo actualizar el initramfs."
        echo "Por favor, actualiza tu initramfs manualmente usando el comando apropiado para tu distribución (ej. 'sudo update-initramfs -u' o 'sudo dracut -f')."
        return 1 # Indicate an error
    fi
    return 0 # Indicate success
}


# Function to enable KVM
enable_kvm() {
    echo "Habilitando módulos KVM..."

    if [ -f "$KVM_BLACKLIST_FILE" ]; then
        echo "Eliminando o comentando las líneas de blacklist en $KVM_BLACKLIST_FILE..."
        # Remove lines that blacklist kvm modules
        sudo sed -i "/blacklist $KVM_MODULES_COMMON/d" "$KVM_BLACKLIST_FILE"
        sudo sed -i "/blacklist $KVM_MODULE_INTEL/d" "$KVM_BLACKLIST_FILE"
        sudo sed -i "/blacklist $KVM_MODULE_AMD/d" "$KVM_BLACKLIST_FILE"

        # Check if file is empty after removing lines, if so, delete it
        if [ ! -s "$KVM_BLACKLIST_FILE" ]; then
            echo "El archivo $KVM_BLACKLIST_FILE está vacío. Eliminándolo..."
            sudo rm "$KVM_BLACKLIST_FILE"
        fi
    else
        echo "El archivo $KVM_BLACKLIST_FILE no existe, KVM ya debería estar habilitado."
    fi

    if update_initramfs_command; then
        echo ""
        echo "¡KVM ha sido habilitado!"
        echo "******************************************************************"
        echo "IMPORTANTE: Debes REINICIAR tu sistema para que los cambios surtan efecto."
        echo "******************************************************************"
    else
        echo "La habilitación de KVM puede no surtir efecto hasta que el initramfs sea actualizado manualmente y el sistema reiniciado."
    fi
}

# Function to disable KVM
disable_kvm() {
    echo "Deshabilitando módulos KVM..."
    echo "Creando/modificando el archivo $KVM_BLACKLIST_FILE..."

    # Ensure the directory exists
    sudo mkdir -p "$(dirname "$KVM_BLACKLIST_FILE")"

    # Add blacklist lines
    echo "blacklist $KVM_MODULES_COMMON" | sudo tee "$KVM_BLACKLIST_FILE" > /dev/null
    if [ "$CPU_TYPE" == "Intel" ]; then
        echo "blacklist $KVM_MODULE_INTEL" | sudo tee -a "$KVM_BLACKLIST_FILE" > /dev/null
    elif [ "$CPU_TYPE" == "AMD" ]; then
        echo "blacklist $KVM_MODULE_AMD" | sudo tee -a "$KVM_BLACKLIST_FILE" > /dev/null
    fi

    if update_initramfs_command; then
        echo ""
        echo "¡KVM ha sido deshabilitado!"
        echo "******************************************************************"
        echo "IMPORTANTE: Debes REINICIAR tu sistema para que los cambios surtan efecto."
        echo "******************************************************************"
    else
        echo "La deshabilitación de KVM puede no surtir efecto hasta que el initramfs sea actualizado manualmente y el sistema reiniciado."
    fi
}

function_kvm(){
    echo "==================================="
    echo "Script para Habilitar/Deshabilitar KVM"
    echo "==================================="
    echo "Se recomienda desabilitar para ejecutar OracleVirtualBox"
    echo "Es necesario para ejecutar las VM correctamente"
    echo "==================================="
    echo "1. Habilitar KVM"
    echo "2. Deshabilitar KVM"
    echo "3. Salir"
    echo "-----------------------------------"

    read -p "Elige una opción (1, 2 o 3): " choice

    case $choice in
        1)
            enable_kvm
            ;;
        2)
            disable_kvm
            ;;
        3)
            echo "Saliendo sin hacer cambios."
            break
            ;;
        *)
            echo -e "Opción inválida. Por favor, elige 1, 2 o 3.\n\n"
            ;;
    esac
}