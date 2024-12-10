# Minitutorial de Github
Github es una herramienta que nos permite la documentación y control de versiones del código

#### Obtén el repositorio
Esto nos ayuda a obtener todo el repositorio en nuestra PC personal y poder tener acceso al código
```bash
git clone https://github.com/p3p3p3k4z/script_Debian.git
```
#### Crea tu Primer Commit
Esto te ayudara a poder subir tus cambios o tu código a github. Recuerda hacer esto en la carpeta donde esta tu espacio de trabajo

**1.Inicia Git**
```bash
git init
```

**2.Añadir archivos**
Añade todos los archivos de tu espacio de trabajo
```bash
git add .
```
Añade un archivo
```bash
git add main.py
```
Añade una carpeta
```bash
git add carpeta/
```

**3.Hacer tu commit**
Aquí darás un breve mensaje que fue lo que cambiaste
```bash
git commit -m "archivos corregidos"
```

**4.Añadir el repositorio**
```bash
git remote add origin https://github.com/p3p3p3k4z/script_Debian.git
```
si se equivoca con el repositorio
```bash
git remote set-url origin https://github.com/p3p3p3k4z/script_Debian.git
```

**5.Subir tus cambios**
```bash
git push -u origin main
```
En caso de Fallas
```bash
git push -u origin main --force
```

A continuación te pedirá tu usuario, después tu contraseña o llave.
Felicidades!!! Ya sabes usar github

#### Hacer cambios
```bash
git add .
git commit -m "Descripción de los cambios"
git push origin main
```

#### Recibir cambios
Cuando alguien actualiza su codigo es necesario recibir el codigo mas actualizado
```bash
git pull origin main
```
#### Regresar a una version anterior
```bash
git clone <url-del-repositorio>
git checkout version_1
git log --oneline
git reset --hard <commit-id>
git push --force origin version_1
```
#### Crear una nueva rama
```bash
git checkout -b <nombre-de-la-nueva-rama>
git push origin <rama_creada>
```

#### General llave
Esto es en caso de no admitir la contraseña
<https://github.com/settings/tokens>
