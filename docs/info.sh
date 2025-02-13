#! /bin/bash

function leer_comandos(){
    read
	cat ./docs/SISTEMA.md | more
}

function leer_git(){
    read
	cat ./docs/GIT.md | more
}