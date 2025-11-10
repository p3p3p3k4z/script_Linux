#! /bin/bash

source ./pack/paquetes.sh    
source ./pack/gestor_pack.sh 

source ./decorador/separador.sh
source ./decorador/color.sh
source ./decorador/dibujo_gato.sh
source ./decorador/dibujo_cafe.sh

function nueva_pc(){
    clear;

    echo -e "${colorVerde}Bienvenid@ a tu nueva PC... Se comenzará a instalar todo lo necesario.${finColor}"
    echo -e "\n"
    echo -e "\nAlgunas veces los paquetes requieren reiniciar.\n"
    echo -e "Reinicia tu PC en caso de que lo requiera.\n\n"
    cafe_mensaje
    sleep 2
    
    if [ -z "$DISTRO_FAMILY" ]; then
        echo -e "${colorRojo}ERROR: La distribución no ha sido detectada. Por favor, ejecuta el script principal.${finColor}"
        gatitoFin2
        sleep 3
        return 1
    fi

    divisor2
    echo -e "\t\t\t${colorAzul}Se actualizará el sistema (:3${finColor}"
    case "$DISTRO_FAMILY" in
        debian_based) inicio_debian ;;
        fedora_based) inicio_fedora ;;
        opensuse_based) inicio_opensuse ;;
        *) echo "${colorRojo}ERROR: La actualización inicial no está soportada para esta distribución.${finColor}" ;;
    esac

    divisor2
    echo -e "\t\t${colorAzul}Se comenzará a instalar todo lo necesario${finColor}"
    gatitoMedio
    case "$DISTRO_FAMILY" in
        debian_based) instalar_basico_debian ;;
        fedora_based) instalar_basico_fedora ;;
        opensuse_based) instalar_basico_opensuse ;;
        *) echo "${colorRojo}ERROR: La instalación de paquetes básicos no está soportada para esta distribución.${finColor}" ;;
    esac

    divisor2
    echo -e "\t${colorAzul}Se instalarán las herramientas de multimedia${finColor}"
    case "$DISTRO_FAMILY" in
        debian_based) f_media_debian ;;
        fedora_based) f_media_fedora ;;
        opensuse_based) f_media_opensuse ;;
        *) echo "${colorRojo}ERROR: La instalación de herramientas multimedia no está soportada para esta distribución.${finColor}" ;;
    esac

    divisor2
    echo -e "\t${colorAzul}  Se comenzarán a instalar herramientas de programación${finColor}"
    case "$DISTRO_FAMILY" in
        debian_based) 
            f_c_debian
            f_java_debian
            f_python_debian
            sudo nala install geany thonny neovim --assume-yes # Specific for Debian, can be adjusted for other distros
            ;;
        fedora_based) 
            f_c_fedora
            f_java_fedora
            f_python_fedora
            sudo dnf install -y geany thonny neovim tilix
            ;;
        opensuse_based) 
            f_c_opensuse
            f_java_opensuse
            f_python_opensuse
            sudo zypper install -y geany thonny neovim tilix 
            sudo zypper ref
            ;;
        *) echo "${colorRojo}ERROR: La instalación de herramientas de programación no está soportada para esta distribución.${finColor}" ;;
    esac

    divisor2
    echo -e "\t${colorAzul}Se instalarán 'chacharas' para el sistema${finColor}"
    case "$DISTRO_FAMILY" in
        debian_based) f_chacharas_debian ;;
        fedora_based) f_chacharas_fedora ;;
        opensuse_based) f_chacharas_opensuse ;;
        *) echo "${colorRojo}ERROR: La instalación de 'chacharas' no está soportada para esta distribución.${finColor}" ;;
    esac

    case "$DISTRO_FAMILY" in
        debian_based) limpiar_pack_debian ;;
        fedora_based) limpiar_pack_fedora ;;
        opensuse_based) limpiar_pack_opensuse ;;
        *) echo "${colorRojo}ERROR: La limpieza del sistema no está soportada para esta distribución.${finColor}" ;;
    esac

    divisor
	f_pfetch
    sleep 5

    echo -e "\n\n${colorVerde}TU NUEVA PC YA ESTÁ LISTA PARA USAR :^)${finColor}"
    echo -e "${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
    gatitoFin2
}
    
function bspwm(){
    if [[ "$DISTRO_FAMILY" != "debian_based" ]]; then
        echo -e "${colorRojo}ERROR: BSPWM es un entorno de escritorio exclusivo para Debian/derivados.${finColor}"
        echo -e "Si te equivocaste, regresa al menú principal."
        sleep 3
        return 1
    fi

    echo -e "${colorVerde}ESTE ES UN ENTORNO DE ESCRITORIO Y COMPLEMENTO EXCLUSIVO PARA DEBIAN${finColor}"
    echo -e "\nSi te equivocaste, reinicia el programa.\n"
    cafe;read
    sudo apt install git inxi -y && cd /tmp && git clone https://github.com/thespation/dpux_bspwm && chmod 755 dpux_bspwm/* -R && cd dpux_bspwm/ && ./instalar.sh
}

function hyperland(){
    if [[ "$DISTRO_FAMILY" != "fedora_based" ]]; then
        echo -e "${colorRojo}ERROR: HYperland es un entorno de escritorio exclusivo para Fedora.${finColor}"
        echo -e "Si te equivocaste, regresa al menú principal."
        sleep 3
        return 1
    fi

    echo -e "${colorVerde}ESTE ES UN ENTORNO DE ESCRITORIO Y COMPLEMENTO EXCLUSIVO PARA Fedora${finColor}"
    echo -e "\nSi te equivocaste, reinicia el programa.\n"
    cafe;read
    bash -c "$(curl -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles/main/setup-fedora.sh)"
}
