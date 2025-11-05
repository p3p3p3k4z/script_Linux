#!/usr/bin/env bash
# sshscan_connect.sh
# Escanea la subred base (por defecto 10.10.11) en un rango de últimos octetos
# y permite conectarse por varios métodos al host elegido.
#
# Uso:
#  ./sshscan_connect.sh            # usa 10.10.11.1-254, ssh, y usuario actual
#  ./sshscan_connect.sh -u user -s 50 -e 80 -m sftp
#  ./sshscan_connect.sh -b 10.0.0 -s 1 -e 20 -p 2222 -m rdp

set -euo pipefail

# --- Defaults ---
BASE="10.10.11"     # prefijo por defecto (sin el último octeto)
START=1
END=254
PORT=22
USER="$(whoami)"
TIMEOUT_SECS=1      # tiempo para probar conexión TCP
SSH_OPTS="-o ConnectTimeout=5 -o StrictHostKeyChecking=ask"
METHOD="ssh"        # método por defecto: ssh

print_help() {
  cat <<EOF
Uso: $0 [opciones]

Opciones:
  -b BASE     Prefijo de red (por ejemplo 10.10.11). Default: ${BASE}
  -s START    Último octeto inicial. Default: ${START}
  -e END      Último octeto final. Default: ${END}
  -p PORT     Puerto (SSH/RDP/servicio). Default: ${PORT}
  -u USER     Usuario. Default: ${USER}
  -t TIMEOUT  Timeout TCP en segundos para el escaneo. Default: ${TIMEOUT_SECS}
  -m METHOD   Método de conexión. Default: ${METHOD}
               Métodos soportados: ssh, sftp, scp, rsync, smb, webdav, rdp
  -h          Muestra esta ayuda

Ejemplos:
  $0 -b 10.10.11 -s 1 -e 50 -m sftp
  $0 -m rdp -p 3389
EOF
}

# Parse args
while getopts "b:s:e:p:u:t:m:h" opt; do
  case "${opt}" in
    b) BASE="${OPTARG}" ;;
    s) START="${OPTARG}" ;;
    e) END="${OPTARG}" ;;
    p) PORT="${OPTARG}" ;;
    u) USER="${OPTARG}" ;;
    t) TIMEOUT_SECS="${OPTARG}" ;;
    m) METHOD="${OPTARG}" ;;
    h) print_help; exit 0 ;;
    *) print_help; exit 1 ;;
  esac
done

# Validate numeric range
if ! [[ "${START}" =~ ^[0-9]+$ ]] || ! [[ "${END}" =~ ^[0-9]+$ ]]; then
  echo "Error: START y END deben ser números (0-255)." >&2
  exit 2
fi
if (( START < 0 || START > 255 || END < 0 || END > 255 || START > END )); then
  echo "Error: rango inválido." >&2
  exit 2
fi

# Normalize method to lowercase
METHOD=$(echo "${METHOD}" | tr '[:upper:]' '[:lower:]')

# Allowed methods
case "${METHOD}" in
  ssh|sftp|scp|rsync|smb|webdav|rdp) ;;
  *)
    echo "Método desconocido: ${METHOD}" >&2
    echo "Métodos soportados: ssh, sftp, scp, rsync, smb, webdav, rdp" >&2
    exit 6
    ;;
esac

echo "Escaneando ${BASE}.${START}-${END} puerto ${PORT} (timeout TCP ${TIMEOUT_SECS}s) como usuario '${USER}', método '${METHOD}'..."
reachable=()

# Function to test puerto TCP. Usa 'timeout' si está disponible; fallback con /dev/tcp.
test_port() {
  local ip=$1
  if command -v timeout >/dev/null 2>&1; then
    timeout "${TIMEOUT_SECS}" bash -c ">/dev/tcp/${ip}/${PORT}" 2>/dev/null && return 0 || return 1
  else
    # sin timeout: intentar con redirección (puede bloquear si no hay timeout del shell)
    bash -c "cat < /dev/tcp/${ip}/${PORT}" >/dev/null 2>&1 && return 0 || return 1
  fi
}

# Escaneo simple secuencial
for i in $(seq "${START}" "${END}"); do
  ip="${BASE}.${i}"
  if test_port "${ip}"; then
    echo "  -> ${ip} (puerto ${PORT} abierto)"
    reachable+=("${ip}")
  else
    :
  fi
done

count=${#reachable[@]}
if (( count == 0 )); then
  echo "No se encontraron hosts con el puerto ${PORT} abierto en el rango indicado."
  exit 3
fi

echo
echo "Hosts alcanzables (${count}):"
for idx in "${!reachable[@]}"; do
  echo "  [$idx] ${reachable[$idx]}"
done

if (( count == 1 )); then
  selection=0
else
  read -rp "Elige índice para conectar (0-$((count-1))) o escribe IP completa: " selection_raw
  if [[ "${selection_raw}" =~ ^[0-9]+$ ]]; then
    if (( selection_raw < 0 || selection_raw >= count )); then
      echo "Índice fuera de rango." >&2
      exit 4
    fi
    selection="${selection_raw}"
  else
    selection_ip="${selection_raw}"
    if [[ "${selection_ip}" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      ok=0
      for ip in "${reachable[@]}"; do
        [[ "${ip}" == "${selection_ip}" ]] && ok=1 && break
      done
      if (( ok == 0 )); then
        echo "La IP ${selection_ip} no está en la lista de hosts alcanzables." >&2
        exit 5
      fi
      ip_to_connect="${selection_ip}"
      echo "Conectando a ${ip_to_connect}..."
      # proceder a acción según método más abajo
    else
      echo "Entrada inválida." >&2
      exit 6
    fi
  fi
fi

# if selection variable not set (solo pasa cuando se eligió índice)
if [[ -z "${ip_to_connect:-}" ]]; then
  ip_to_connect="${reachable[$selection]}"
fi

echo "Intentando conexión a ${ip_to_connect} usando método '${METHOD}'..."

# Helper para comprobar comando y sugerir instalación
require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: se requiere '$1' pero no está instalado o en PATH." >&2
    return 1
  fi
  return 0
}

# Ejecutar la acción según método
case "${METHOD}" in
  ssh)
    exec ssh ${SSH_OPTS} -p "${PORT}" "${USER}@${ip_to_connect}"
    ;;

  sftp)
    if ! require_cmd sftp; then
      echo "Intenta: sudo apt install openssh-client" >&2
      exit 7
    fi
    exec sftp -o ConnectTimeout=5 -o StrictHostKeyChecking=ask -P "${PORT}" "${USER}@${ip_to_connect}"
    ;;

  scp)
    if ! require_cmd scp; then
      echo "Intenta: sudo apt install openssh-client" >&2
      exit 7
    fi
    # Preguntar ruta remota a bajar/subir
    echo "Usando scp. Ejemplo de ruta remota: /home/${USER}/archivo.txt"
    read -rp "Ruta remota (user@host:/ruta ó /ruta en ${ip_to_connect}): " rpath
    read -rp "Destino local (directorio o archivo, default: current dir): " ldest
    ldest="${ldest:-.}"
    # Si no contiene usuario@host: prefix, añadir user@ip:
    if [[ "${rpath}" != *:* ]]; then
      remote="${USER}@${ip_to_connect}:${rpath}"
    else
      remote="${rpath}"
    fi
    echo "Ejecutando: scp -P ${PORT} ${remote} ${ldest}"
    exec scp -P "${PORT}" "${remote}" "${ldest}"
    ;;

  rsync)
    if ! require_cmd rsync; then
      echo "Instálalo con: sudo apt install rsync" >&2
      exit 7
    fi
    echo "Ejemplo de comando rsync (descarga remota a local):"
    echo "  rsync -avz -e 'ssh -p ${PORT}' ${USER}@${ip_to_connect}:/ruta/remota/ ./destino_local/"
    read -rp "¿Deseas ejecutar un rsync ahora? (s/N): " do_rsync
    if [[ "${do_rsync,,}" =~ ^s|y ]]; then
      read -rp "Ruta remota (ej: /var/www/ o /home/${USER}/): " rpath
      read -rp "Destino local (ej: ./backup/): " ldest
      ldest="${ldest:-./}"
      cmd=(rsync -avz -e "ssh -p ${PORT}" "${USER}@${ip_to_connect}:${rpath}" "${ldest}")
      echo "Ejecutando: ${cmd[*]}"
      exec "${cmd[@]}"
    else
      echo "Cancelado rsync. Saliendo."
      exit 0
    fi
    ;;

  smb)
    # Intentar abrir en gestor (gio o xdg-open), sino sugerir smbclient
    url="smb://${ip_to_connect}/"
    if command -v gio >/dev/null 2>&1; then
      echo "Abriendo ${url} con gio (esto usará el gestor de archivos por defecto)..."
      exec gio open "${url}"
    elif command -v xdg-open >/dev/null 2>&1; then
      echo "Abriendo ${url} con xdg-open..."
      exec xdg-open "${url}"
    elif command -v smbclient >/dev/null 2>&1; then
      echo "Usando smbclient para listar recursos en ${ip_to_connect} (te pedirá usuario/contraseña si corresponde)..."
      exec smbclient -L "${ip_to_connect}" -U "${USER}"
    else
      echo "No se encontró 'gio', 'xdg-open' ni 'smbclient'. Instálalo (ej: sudo apt install gvfs-bin smbclient) e intenta de nuevo." >&2
      exit 7
    fi
    ;;

  webdav)
    url="dav://${ip_to_connect}/"
    # probar gio/xdg-open o cadaver
    if command -v gio >/dev/null 2>&1; then
      echo "Abriendo ${url} con gio (gestor de archivos)..."
      exec gio open "${url}"
    elif command -v xdg-open >/dev/null 2>&1; then
      echo "Abriendo ${url} con xdg-open..."
      exec xdg-open "${url}"
    elif command -v cadaver >/dev/null 2>&1; then
      echo "Usando cadaver (cliente WebDAV en terminal)..."
      exec cadaver "${url}"
    else
      echo "No se encontró 'gio', 'xdg-open' ni 'cadaver'. Instala davfs2/cadaver o usa un gestor de archivos que soporte WebDAV." >&2
      exit 7
    fi
    ;;

  rdp)
    # Usar xfreerdp si existe, o rdesktop
    if command -v xfreerdp >/dev/null 2>&1; then
      echo "Conectando con xfreerdp a ${ip_to_connect}:${PORT} ..."
      # abrir RDP sin contraseña pedida por defecto; xfreerdp pedirá si hace falta
      exec xfreerdp /v:${ip_to_connect}:${PORT}
    elif command -v rdesktop >/dev/null 2>&1; then
      echo "Conectando con rdesktop a ${ip_to_connect}:${PORT} ..."
      exec rdesktop -u "${USER}" -p "" "${ip_to_connect}:${PORT}"
    else
      echo "No se encontró 'xfreerdp' ni 'rdesktop'. Instálalo (ej: sudo apt install freerdp2-x11) e intenta de nuevo." >&2
      exit 7
    fi
    ;;

  *)
    echo "Método no implementado: ${METHOD}" >&2
    exit 8
    ;;
esac
