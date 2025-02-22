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
            1) f_c ;;
            2) f_java ;;
            3) f_python ;;
            4) 
                f_c;
                f_java;
                f_python;
                ;;
            5)
                echo "Saliendo del menu."
                break
                ;;
            *)
                echo "Opción inválida. Por favor, selecciona una opción válida."
                echo "Regresando..."; break;
                ;;
        esac

        echo "Regresando.."
        read  
    done
}

function instalar_IDE() {
	local opp
	
    while true; do
        echo -e "\nIDES DISPONIBLES: "
        echo "1- Geany (IDE RECOMENDADO)"
        echo "2- Thonny (IDE PYTHON RECOMENDADO)"
        echo "3- Spider (IDE PYTHON CIENCIA DE DATOS)"
        echo "4- Lanarus (IDE PASCAL)"
        echo "5- NEOVIM"
        echo "6- Emacs"
        echo "7- Salir"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) sudo nala install geany ;;
            2) sudo nala install thonny ;;
            3) sudo nala install spyder ;;
            4) sudo nala install lazarus-ide;;
            5) sudo nala install neovim;;
            6) sudo nala install emacs ;;
            7)
                echo "Saliendo del menu."
                break
                ;;
            *)
                echo "Opción inválida. Por favor, selecciona una opción válida."
                echo "Regresando..."; break;
                ;;
        esac

        echo "Regresando..."
        read  
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
        echo "10- Regresar al menu principal"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) sudo nala install cbonsai;;
            2) sudo nala install lolcat;;
            3) sudo nala install toilet;;
            4) sudo nala install cowsay;;
            5) sudo nala install fortunes-es;;
            6) sudo nala install cmatrix;;
			7) sudo nala install oneko;;
			8) sudo nala install hollywood;;
			9) f_chacharas;;
            10) echo "Saliendo del menu"; break ;;
            *)  echo "Opción inválida. Por favor, selecciona una opción válida." 
				echo "Regresando..."; break;
				;;    
        esac

        echo "Regresando..."
        read
    done
	}

function menu_instalar() {
    while true; do
        echo -e "\n\nMenú de Instalacion de paquetes:"
        echo "1- Paquetes Basicos"
        echo "2- Paquetes de Programacion"
        echo "3- Paquetes de IDE"
        echo "4- Paquetes Curiosos"
        echo "5- Paquete para impresora HP"
        echo "- - - - - DEBIAN - - - - -"
        echo "a- Instalar Wine"
	    echo "b- Instalar Docker"
        echo "c- Paquetes flatpack"
        echo "- - - - - - - - - - - - - -"
        echo "0- Regresar al menu principal"
        echo "Teclea una opción"
        read opp

        case $opp in
            1) instalar_basico;;
            2) instalar_programacion;;
            3) instalar_IDE;;
            4) instalar_chacharas;;
            5)f_impresora_hp;;
            a) f_wine;;
		    b) f_docker;;
            c) f_flatpak;;
            0) echo "Saliendo del menu"; break ;;
            *) echo "Opción inválida. Por favor, selecciona una opción válida." ;;
        esac

        echo "Regresando..."
        read
    done
}
