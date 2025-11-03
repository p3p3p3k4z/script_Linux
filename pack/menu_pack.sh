#! /bin/bash

source ./pack/paquetes.sh

function instalar_programacion() {
    local opp

    while true; do
        echo -e "\nLENGUAJES DISPONIBLES: "
        echo "1- C/C++"
        echo "2- Java 17"
        echo "3- Python"
        echo "4- ALL"
        echo "5- Salir"
        echo "Teclea una opción"
        read opp

        case $opp in
            1)
                case "$DISTRO_FAMILY" in
                    debian_based) f_c_debian ;;
                    fedora_based) f_c_fedora ;;
                    opensuse_based) f_c_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de C/C++ no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            2)
                case "$DISTRO_FAMILY" in
                    debian_based) f_java_debian ;;
                    fedora_based) f_java_fedora ;;
                    opensuse_based) f_java_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de Java no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            3)
                case "$DISTRO_FAMILY" in
                    debian_based) f_python_debian ;;
                    fedora_based) f_python_fedora ;;
                    opensuse_based) f_python_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de Python no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            4) # Install ALL
                case "$DISTRO_FAMILY" in
                    debian_based)
                        f_c_debian
                        f_java_debian
                        f_python_debian
                        ;;
                    fedora_based)
                        f_c_fedora
                        f_java_fedora
                        f_python_fedora
                        ;;
                    opensuse_based)
                        f_c_opensuse
                        f_java_opensuse
                        f_python_opensuse
                        ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de todos los lenguajes no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            5)
                echo "Saliendo del menú de lenguajes."
                break
                ;;
            *)
                echo -e "${colorRojo}Opción inválida. Por favor, selecciona una opción válida.${finColor}"
                ;;
        esac

        echo -e "\n${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
        read -n 1 # Wait for user input to continue
    done
}

function instalar_IDE() {
    local opp
    
    while true; do
        echo -e "\nIDES DISPONIBLES: "
        echo "1- Geany (IDE RECOMENDADO)"
        echo "2- Thonny (IDE PYTHON RECOMENDADO)"
        echo "3- Spyder (IDE PYTHON CIENCIA DE DATOS)"
        echo "4- Lazarus (IDE PASCAL)" 
        echo "5- NEOVIM"
        echo "6- Emacs"
        echo "7- Salir"
        echo "Teclea una opción"
        read opp

        local package_name=""
        local install_cmd=""

        case "$DISTRO_FAMILY" in
            debian_based) install_cmd="sudo apt install -y";;
            fedora_based) install_cmd="sudo dnf install -y";;
            opensuse_based) install_cmd="sudo zypper install -y";;
            *) echo "-e ${colorRojo}ERROR: Instalación de IDEs no soportada para esta distribución.${finColor}"; continue;;
        esac

        case $opp in
            1) package_name="geany";;
            2) package_name="thonny";;
            3) package_name="spyder";;
            4) package_name="lazarus";; 
            5) package_name="neovim";;
            6) package_name="emacs";;
            7) echo "Saliendo del menú de IDEs."; break ;;
            *) echo -e "${colorRojo}Opción inválida. Por favor, selecciona una opción válida.${finColor}";;
        esac

        if [ -n "$package_name" ]; then 
            echo "Instalando $package_name..."
            $install_cmd "$package_name"
        fi

        echo -e "\n${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
        read -n 1
    done
}

function instalar_chacharas(){
    local opp
    
    while true; do
        echo -e "\nPAQUETES CURIOSOS PARA TERMINAL:"
        echo "1- CBONSAI (Dibujar bonsai desde terminal)"
        echo "2- LOLCAT (Un cat con colores)"
        echo "3- TOILET (Palabra ASCII/Editor)"
        echo "4- COWSAY (Animales dando una frase)"
        echo "5- FORTUNE (Frase de fortuna del dia)"
        echo "6- CMATRIX (Simulador de matrix)"
        echo "7- ONEKO (Mause de gato)"
        echo "8- HOLLYWOOD (Creerse hacker)"
        echo "9- ALL"
        echo "10- Regresar al menú principal"
        echo "Teclea una opción"
        read opp

        case $opp in
            1)
                case "$DISTRO_FAMILY" in
                    debian_based) sudo apt install -y cbonsai;;
                    fedora_based) echo -e "${colorRojo}cbonsai no disponible directamente en repositorios de Fedora. Considera instalación manual.${finColor}";; # Adjust as needed
                    opensuse_based) echo -e "${colorRojo}cbonsai no disponible directamente en repositorios de OpenSUSE. Considera instalación manual.${finColor}";; # Adjust as needed
                esac
                ;;
            2)
                case "$DISTRO_FAMILY" in
                    debian_based) sudo apt install -y lolcat;;
                    fedora_based) sudo dnf install -y lolcat;;
                    opensuse_based) sudo zypper install -y lolcat;;
                esac
                ;;
            3)
                case "$DISTRO_FAMILY" in
                    debian_based) sudo apt install -y toilet;;
                    fedora_based) sudo dnf install -y toilet;;
                    opensuse_based) sudo zypper install -y toilet;;
                esac
                ;;
            4)
                case "$DISTRO_FAMILY" in
                    debian_based) sudo apt install -y cowsay;;
                    fedora_based) sudo dnf install -y cowsay;;
                    opensuse_based) sudo zypper install -y cowsay;;
                esac
                ;;
            5)
                case "$DISTRO_FAMILY" in
                    debian_based) sudo apt install -y fortunes-es;;
                    fedora_based) echo -e "${colorRojo}fortunes-es no disponible directamente en repositorios de Fedora. Considera 'fortune-mod'.${finColor}";;
                    opensuse_based) echo -e "${colorRojo}fortunes-es no disponible directamente en repositorios de OpenSUSE. Considera 'fortune'.${finColor}";;
                esac
                ;;
            6)
                case "$DISTRO_FAMILY" in
                    debian_based) sudo apt install -y cmatrix;;
                    fedora_based) sudo dnf install -y cmatrix;;
                    opensuse_based) sudo zypper install -y cmatrix;;
                esac
                ;;
            7)
                case "$DISTRO_FAMILY" in
                    debian_based) sudo apt install -y oneko;;
                    fedora_based) sudo dnf install -y oneko;;
                    opensuse_based) sudo zypper install -y oneko;;
                esac
                ;;
            8)
                case "$DISTRO_FAMILY" in
                    debian_based) sudo apt install -y hollywood;;
                    fedora_based) echo -e "${colorRojo}hollywood no disponible directamente en repositorios de Fedora. Considera instalación manual.${finColor}";;
                    opensuse_based) echo -e "${colorRojo}hollywood no disponible directamente en repositorios de OpenSUSE. Considera instalación manual.${finColor}";;
                esac
                ;;
            9) # Install ALL chacharas
                case "$DISTRO_FAMILY" in
                    debian_based) f_chacharas_debian ;;
                    fedora_based) f_chacharas_fedora ;;
                    opensuse_based) f_chacharas_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de 'chacharas' no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            10) echo "Saliendo del menú de 'chacharas'."; break ;;
            *)  echo -e "${colorRojo}Opción inválida. Por favor, selecciona una opción válida.${finColor}" ;;    
        esac

        echo -e "\n${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
        read -n 1
    done
}

# --- Main Installation Menu ---
function menu_instalar() {

    if [ -z "$DISTRO_FAMILY" ]; then
        echo -e "${colorRojo}Error: La distribución no ha sido detectada correctamente. Ejecuta el script principal.${finColor}"
        sleep 3
        return 1
    fi

    while true; do
        clear
        divisor 
        echo -e "\t\t        - - - MENÚ DE INSTALACIÓN DE PAQUETES - - -"
        echo "1- Paquetes Básicos"
        echo "2- Paquetes de Programación (Lenguajes)"
        echo "3- Paquetes de IDEs"
        echo "4- Paquetes Curiosos (Chacharas)"
        echo "5- Paquete para impresora HP"
        echo "6- Instalar Wine"
        echo "7- Instalar Docker"
        echo "8- Paquetes Flatpak"
        echo "9- Paquetes de diseño"
        echo "0- Regresar al menú principal"
        divisor
        echo -e "${colorGris}Teclea una opción${finColor}"
        read opp

        case $opp in
            1) 
                case "$DISTRO_FAMILY" in
                    debian_based) instalar_basico_debian ;;
                    fedora_based) instalar_basico_fedora ;;
                    opensuse_based) instalar_basico_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de paquetes básicos no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            2) instalar_programacion ;;
            3) instalar_IDE ;;
            4) instalar_chacharas ;;
            5)
                case "$DISTRO_FAMILY" in
                    debian_based) f_impresora_hp_debian ;;
                    fedora_based) f_impresora_hp_fedora ;;
                    opensuse_based) f_impresora_hp_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de impresora HP no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            6)
                case "$DISTRO_FAMILY" in
                    debian_based) f_wine_debian ;;
                    fedora_based) f_wine_fedora ;;
                    opensuse_based) f_wine_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de Wine no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            7)
                case "$DISTRO_FAMILY" in
                    debian_based) f_docker_debian ;;
                    fedora_based) f_docker_fedora ;;
                    opensuse_based) f_docker_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de Docker no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            8)
                case "$DISTRO_FAMILY" in
                    debian_based) f_flatpak_debian ;;
                    fedora_based) f_flatpak_fedora ;;
                    opensuse_based) f_flatpak_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Instalación de Flatpak no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
            9) 
				case "$DISTRO_FAMILY" in
                    debian_based) f_diseno_debian ;;
                    fedora_based) echo "Aun no disponible" ;;
                    opensuse_based) f_diseno_opensuse ;;
                    *) echo -e "${colorRojo}ERROR: Paquetes de diseño no soportada para esta distribución.${finColor}" ;;
                esac
                ;;
                
            0) echo "Saliendo del menú de instalación."; break ;;
            *) echo -e "${colorRojo}Opción inválida. Por favor, selecciona una opción válida.${finColor}" ;;
        esac

        echo -e "\n${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
        read -n 1 
    done
}
