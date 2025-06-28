# script_linux

Este script es creado con la finalidad de ahorrar tiempos a la hora de estar instalando paquetes que uso habitualmente.
Constantemente necesito instalar los mismos paquetes para nuevas pc o cada que rompo mi sistema linux. 
Inicialmente lo hice para Debian y distros derivadas (Ubuntu, Linux Mint, Zorin os, Pop OS, ect). Por lo que es donde mejor se desempeña el script.
A lo largo de mi aprendizaje con linux he probado mas distros y por ende ha cambiado la forma de instalación, pero no la necesidad de instalar mis paquetes favoritos.
Actualmente he añadido las distros que usado en este tiempo: Debian, Opensuse y Fedora.
Espero y sea de utilidad para alguien mas, asi como me ha ayudado a mi :3

El proyecto consiste en un asistente de gestion e instalaccion de paquetes. Es decir tiene las funciones de:
- Actualizar
- Eliminar
- Buscar
- Instalar

Para la instalacion de paquetes. Agrege algunos como:
- C/C++
- Java 17
- Python
- Docker
- Flatpak
- Wine
- IDES
- Extras ;)

---
Para comenzar a usarlo basta con clonar el repositorio.
Abrir la terminal y ejecutar:

```bash
sudo make run
```

---

![preview](inicio.png)

Por el momento no planeo agregar mas funcionalidades a este programa, mas que el de instalar paquetes o herramientas (ultimamente que encontrado buenas herramientas CLI en rust y dotfiles que podria añadir).

Este miniproyecto que solo me sirvio como practica para los conocimientos que adquiri sobre bash.