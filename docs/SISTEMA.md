# Manipulacion de Ficheros y Directorios
Fichero: Archivo
Directorios: Carpeta

ls      listar ficheros y directorios
ls -l   listar formato largo 
ls -a   listar ocultos
ls -lh  listar con tamaño

cd      moverse entre directorios
cd 		/home/usuario    Moverse a carpeta
		~/
cd ..   Regresar

pwd     donde estamos

mkdir   crear directorios
mkdir 	~/ [NOMBRE]

touch   crear ficheros


rm      borrar archivo
rmdir   borrar directorio vacio
rm -rf  borrar todo el directorio

cp      copiar
		cp arch1 copia

mv      mover fichero

cat     ver fichero
head    ver n primeras lineas a ver
		head -n 2 "archivo"
tail    ver las ultimas lineas

grep    ver ocurrencias
		grep -in "print" main.c 

ln -s   link simbolico(acceso directo)

find    encntrar fichero
		find *.c Directorio
		find Firectorio/ *.c

## Editores principales de la terminal
nano nvim vim vi 

## Permisos
su  	llamada como superusuario
sudo    hacer como superusuario

chmod   Cambiar los permisos
		chmod +x archivo    permiso de ejecucion

chgrp   Cambiar permiso de usuario

unmask  retornar los permisos por defectos

## Administracion de archivos
- Compresion
    tar -cf     comprimir
    tar -xf     descomprimir

## procesos en control
top htop btop   permite conocer los procesos

kill        terminar un proceso
killall     termina todo de un programa 
programa &  continuar usado la terminal

## Sistema
whoami      saber nombre de usuario
uptime      saber tiempo encendido,etc
lscpu       todo cpu
lspci       controladores y lo conectado
lsusb       usbs
ifconfig    red
ping        comprobar la conexion
ssh         conectarte de forma remota
who         quien soy

wget, curl  permite descargar de internet

## Operadores de redireccion
- Permite guardar las acciones
echo "Hola Mundo" > archivo.txt

## Variables de entorno
- Configurar servidores, etc
export NOMBRE_VAR=1

- eliminar
unset NOMBRE_VAR

- imprimir
echo $NOMBRE_VAR

- lista de variables
prinenv

## Administrador de paquetes
apt
nala
pacman
dnd

## Bash
Este tipo de archivos se guardan con la extension .sh
echo    Permite imprimir en la shell
