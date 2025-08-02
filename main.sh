#! /bin/bash

# --- Decoradores y utilidades ---
source decorador/color.sh
source decorador/dibujo_cafe.sh
source decorador/dibujo_gato.sh
source decorador/separador.sh

# --- Documentación e Información ---
source docs/info.sh

# --- Paquetes y Gestores ---
source pack/paquetes.sh
source pack/install_pack.sh
source pack/gestor_pack.sh
source pack/menu_pack.sh 

# --- Tools ---
source tools/toggle_kvm.sh

# --- Funciones Generales ---
function version(){
    echo -e "\t\tVersion 3.0"
    echo -e "\t\t\tRealizado por p3p3p4k4z ^^\n"
    gatito2
    }

function ctrl_c() {
    echo -e "\n${colorRojo}¡Operación interrumpida!${finColor}"
    echo -e "Si existio algun error, reportarlo o reinicia...\n"
    gatito2
    exit 1
    }

mostrar_ayuda() {
  echo "Uso: $0 [opciones]"
  echo ""
  echo "Opciones:"
  echo "  --help        Muestra este mensaje de ayuda"
  echo "  --install     Instala todo lo necesario para una nueva pc"
  echo "  --version     Versión del script"
  exit 0
}

# --- Detección de Distribución ---
# Esta función detecta la familia de la distribución y exporta DISTRO_FAMILY y OS_ID.
detect_distro() {
    DISTRO_FAMILY=""
    OS_ID=""

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_ID=$ID
        case "$ID" in
            debian|ubuntu|linuxmint|pop|raspbian)
                DISTRO_FAMILY="debian_based"
                ;;
            fedora|rhel|centos|rocky|almalinux)
                DISTRO_FAMILY="fedora_based"
                ;;
            opensuse-leap|opensuse-tumbleweed)
                DISTRO_FAMILY="opensuse_based"
                ;;
            *)
                case "$ID_LIKE" in
                    *debian*) DISTRO_FAMILY="debian_based" ;;
                    *fedora*|*rhel*) DISTRO_FAMILY="fedora_based" ;;
                    *suse*) DISTRO_FAMILY="opensuse_based" ;;
                    *) DISTRO_FAMILY="unknown" ;;
                esac
                ;;
        esac
    elif type lsb_release >/dev/null 2>&1; then
        local lsb_id=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
        case "$lsb_id" in
            ubuntu|debian|linuxmint|pop|sparky|raspbian) DISTRO_FAMILY="debian_based" ;;
            fedora|redhat|centos) DISTRO_FAMILY="fedora_based" ;;
            opensuse|suse) DISTRO_FAMILY="opensuse_based" ;;
            *) DISTRO_FAMILY="unknown" ;;
        esac
        OS_ID=$lsb_id
    elif [ -f /etc/debian_version ]; then DISTRO_FAMILY="debian_based"; OS_ID="debian";
    elif [ -f /etc/redhat-release ]; then DISTRO_FAMILY="fedora_based"; OS_ID="redhat_based_fallback";
    elif [ -f /etc/SuSE-release ]; then DISTRO_FAMILY="opensuse_based"; OS_ID="opensuse_fallback";
    else DISTRO_FAMILY="unknown"; OS_ID=$(uname -s | tr '[:upper:]' '[:lower:]');
    fi

    export DISTRO_FAMILY
    export OS_ID
}

# --- Menús Específicos por Distribución ---

mostrar_menu_debian() {
    while true; do
        clear
        divisor
        echo -e "\t\t        - - - MENÚ DEBIAN/DERIVADAS - - -"
        echo -e "\t\t1- Inicio básico para nueva PC"
        echo -e "\t\t2- Gestor de paquetes (APT)"
        echo -e "\t\t3- Instalar paquetes específicos"
        echo -e "\t\t4- Escritorio BSPWM (¡SOLO PARA DEBIAN!)"
        echo -e "\t\t5- Comandos generales de LINUX"
        echo -e "\t\t6- Comandos para GIT"
        echo -e "\t\t0- Volver al menú principal / Salir"
        divisor
        echo -e "${colorGris}Teclea una opción${finColor}";read op_debian

        case $op_debian in
            1) nueva_pc;; 
            2) menu_pack;; 
            3) menu_instalar;; 
            4) bspwm;; 
            5)  divisor; echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"; divisor
                gatitoFin2; sleep 3; leer_comandos;
                ;;
            6)  divisor; echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"; divisor
                gatitoFin2; sleep 3; leer_git;
                ;;
            0) break;; 
            *) echo -e "${colorRojo}Opción no válida para Debian/Derivadas.${finColor}\n\n";;
        esac
        echo -e "${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
        read -n 1
    done
}

mostrar_menu_fedora() {
    while true; do
        clear
        divisor
        echo -e "\t\t        - - - MENÚ FEDORA/DERIVADAS - - -"
        echo -e "\t\t1- Inicio básico para nueva PC"
        echo -e "\t\t2- Gestor de paquetes (DNF)"
        echo -e "\t\t3- Instalar paquetes específicos"
        echo -e "\t\t4- Configurar RPM Fusion (repositorios adicionales)"
        echo -e "\t\t5- Comandos generales de LINUX"
        echo -e "\t\t6- Comandos para GIT"
		echo -e "\t\t7- ESCRITORIO HYPERLAND"
        echo -e "\t\t8- Activar o Desactivar KVM"
        echo -e "\t\t0- Volver al menú principal / Salir"
        divisor
        echo -e "${colorGris}Teclea una opción${finColor}";read op_fedora

        case $op_fedora in
            1) nueva_pc;; 
            2) menu_pack;; 
            3) menu_instalar;;
            4)
                echo "Configurando repositorios RPM Fusion..."
                # Asegúrate de tener 'rpm' instalado para usar 'rpm -E %fedora'.
                sudo dnf install -y "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
                sudo dnf install -y "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
                sudo dnf update --refresh
                echo "RPM Fusion configurado."
                ;;
            5)  divisor; echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"; divisor
                gatitoFin2; sleep 3; leer_comandos;
                ;;
            6)  divisor; echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"; divisor
                gatitoFin2; sleep 3; leer_git;
                ;;
			7) hyperland;;
            8) function_kvm;;
            0) break;;
            *) echo -e "${colorRojo}Opción no válida para Fedora/Derivadas.${finColor}\n\n";;
        esac
        echo -e "${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
        read -n 1
    done
}

mostrar_menu_opensuse() {
    while true; do
        clear
        divisor
        echo -e "\t\t        - - - MENÚ OPENSUSE/DERIVADAS - - -"
        echo -e "\t\t1- Inicio básico para nueva PC"
        echo -e "\t\t2- Gestor de paquetes (ZYPPER)"
        echo -e "\t\t3- Instalar paquetes específicos"
        echo -e "\t\t4- Configurar Packman (repositorios multimedia)"
        echo -e "\t\t5- Comandos generales de LINUX"
        echo -e "\t\t6- Comandos para GIT"
        echo -e "\t\t0- Volver al menú principal / Salir"
        divisor
        echo -e "${colorGris}Teclea una opción${finColor}";read op_opensuse

        case $op_opensuse in
            1) nueva_pc;; 
            2) menu_pack;; 
            3) menu_instalar;; 
            4)
                echo "Configurando repositorios Packman..."
                # Se usa grep/cut/tr para obtener la VERSION_ID, que es más robusta.
                local opensuse_version=$(grep VERSION_ID /etc/os-release | cut -d'=' -f2 | tr -d '"')
                sudo zypper addrepo -cfp 90 "https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_${opensuse_version}/" packman
                sudo zypper refresh
                sudo zypper dist-upgrade --from packman --allow-vendor-change
                echo "Packman configurado. Realiza un 'zypper dup' si es necesario."
                ;;
            5)  divisor; echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"; divisor
                gatitoFin2; sleep 3; leer_comandos;
                ;;
            6)  divisor; echo -e "\tRECUERDA CUANDO TERMINES DE LEER PRESIONA Q PARA SALIR"; divisor
                gatitoFin2; sleep 3; leer_git;
                ;;
            0) break;;
            *) echo -e "${colorRojo}Opción no válida para OpenSUSE/Derivadas.${finColor}\n\n";;
        esac
        echo -e "${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
        read -n 1
    done
}

# --- Gestión de Argumentos de Línea de Comandos (antes de la lógica principal) ---
if [[ "$1" == "--help" ]]; then
  mostrar_ayuda;
fi

if [[ "$1" == "--version" ]]; then
  version;
fi

if [[ "$1" == "--install" ]]; then
  # Para --install, primero necesitamos detectar la distro para que 'nueva_pc' funcione correctamente
  detect_distro
  if [ "$DISTRO_FAMILY" == "unknown" ]; then
      echo -e "${colorRojo}ERROR: No se pudo detectar una distribución compatible para la instalación automática.${finColor}"
      exit 1
  fi
  nueva_pc;
  exit 0 # Salir después de la instalación automática
fi

trap ctrl_c SIGINT

clear

nombre=$(whoami)
echo -e "\t\tBienvenido accediste como:${colorRojo} $nombre ${finColor}"
echo -e "\t\tEste es un script para gestionar paquetes y herramientas"
echo -e "\t\tCompatible en sistemas basados en Debian, Fedora y OpenSUSE."
version
echo -e "${colorAmarillo}Presiona cualquier tecla para continuar...${finColor}"
read

# --- Verificación de Permisos de Superusuario ---
#if [ "$(id -u)" == "0" ];then
    # Llamar a la función de detección al inicio del main
    detect_distro # Esto establecerá las variables $DISTRO_FAMILY y $OS_ID

    # Mostrar el menú correspondiente según la familia de la distribución
    case "$DISTRO_FAMILY" in
        debian_based)
            mostrar_menu_debian
            ;;
        fedora_based)
            mostrar_menu_fedora
            ;;
        opensuse_based)
            mostrar_menu_opensuse
            ;;
        *)
            echo -e "${colorRojo}\n\nERROR: Distribución '$OS_ID' no soportada o desconocida.${finColor}"
            echo -e "Por favor, utiliza este script en una distribución basada en Debian, Fedora o OpenSUSE."
            gatitoFin2
            sleep 5
            exit 1
            ;;
    esac
#else
#    echo -e "${colorAmarillo}\n\nPor favor, reinicia el programa e inicia como superusuario (usando 'sudo ./tu_script.sh')...${finColor}"
#    gatitoFin2
#    sleep 5
#    exit 0
#fi

echo -e "\n${colorVerde}¡Gracias por usar el script!${finColor}"
gatitoFin2
exit 0