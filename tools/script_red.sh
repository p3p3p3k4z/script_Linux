#!/usr/bin/env bash
# sshscan_connect.sh
# Escanea la subred base (por defecto 10.10.11) en un rango de últimos octetos
# y permite conectarse por SSH al host elegido.
#
# Uso:
#  ./sshscan_connect.sh            # usa 10.10.11.1-254 y usuario actual
#  ./sshscan_connect.sh -u user -s 50 -e 80
#  ./sshscan_connect.sh -b 10.0.0 -s 1 -e 20 -p 2222

set -euo pipefail

# --- Defaults ---
BASE="10.10.11"     # prefijo por defecto (sin el último octeto)
START=1
END=254
PORT=22
USER="$(whoami)"
TIMEOUT_SECS=1      # tiempo para probar conexión TCP
SSH_OPTS="-o ConnectTimeout=5 -o StrictHostKeyChecking=ask"

print_help() {
  cat <<EOF
Uso: $0 [opciones]

Opciones:
  -b BASE     Prefijo de red (por ejemplo 10.10.11). Default: ${BASE}
  -s START    Último octeto inicial. Default: ${START}
  -e END      Último octeto final. Default: ${END}
  -p PORT     Puerto SSH. Default: ${PORT}
  -u USER     Usuario SSH. Default: ${USER}
  -t TIMEOUT  Timeout TCP en segundos para el escaneo. Default: ${TIMEOUT_SECS}
  -h          Muestra esta ayuda
EOF
}

# Parse args
while getopts "b:s:e:p:u:t:h" opt; do
  case "${opt}" in
    b) BASE="${OPTARG}" ;;
    s) START="${OPTARG}" ;;
    e) END="${OPTARG}" ;;
    p) PORT="${OPTARG}" ;;
    u) USER="${OPTARG}" ;;
    t) TIMEOUT_SECS="${OPTARG}" ;;
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

echo "Escaneando ${BASE}.${START}-${END} puerto ${PORT} (timeout TCP ${TIMEOUT_SECS}s) como usuario '${USER}'..."
reachable=()

# Function to test puerto TCP. Usa 'timeout' si está disponible; fallback con /dev/tcp.
test_port() {
  local ip=$1
  # Preferir timeout + bash /dev/tcp para máxima compatibilidad:
  if command -v timeout >/dev/null 2>&1; then
    timeout "${TIMEOUT_SECS}" bash -c ">/dev/tcp/${ip}/${PORT}" 2>/dev/null && return 0 || return 1
  else
    # sin timeout: intentar con redirección (puede bloquear si no hay timeout del shell)
    bash -c "cat < /dev/tcp/${ip}/${PORT}" >/dev/null 2>&1 && return 0 || return 1
  fi
}

# Escaneo simple secuencial (rápido en redes pequeñas). Para rangos grandes, ejecuta en paralelo por tu cuenta.
for i in $(seq "${START}" "${END}"); do
  ip="${BASE}.${i}"
  if test_port "${ip}"; then
    echo "  -> ${ip} (ssh abierto)"
    reachable+=("${ip}")
  else
    # opcional: comentar para no mostrar hosts cerrados
    # echo "  - ${ip} cerrado"
    :
  fi
done

count=${#reachable[@]}
if (( count == 0 )); then
  echo "No se encontraron hosts con SSH abierto en el rango indicado."
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
  # Pedir selección (si hay más de 1)
  read -rp "Elige índice para conectar (0-${count-1}) o escribe IP completa: " selection_raw
  # si el usuario puso una IP, usarla; si puso número, validar
  if [[ "${selection_raw}" =~ ^[0-9]+$ ]]; then
    if (( selection_raw < 0 || selection_raw >= count )); then
      echo "Índice fuera de rango." >&2
      exit 4
    fi
    selection="${selection_raw}"
  else
    # tratarlo como IP directa
    selection_ip="${selection_raw}"
    # simple validación
    if [[ "${selection_ip}" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      # confirmar que está en la lista reachable
      ok=0
      for ip in "${reachable[@]}"; do
        [[ "${ip}" == "${selection_ip}" ]] && ok=1 && break
      done
      if (( ok == 0 )); then
        echo "La IP ${selection_ip} no está en la lista de hosts alcanzables." >&2
        exit 5
      fi
      # usar esa ip
      ip_to_connect="${selection_ip}"
      echo "Conectando a ${ip_to_connect}..."
      exec ssh ${SSH_OPTS} -p "${PORT}" "${USER}@${ip_to_connect}"
    else
      echo "Entrada inválida." >&2
      exit 6
    fi
  fi
fi

ip_to_connect="${reachable[$selection]}"
echo "Conectando a ${ip_to_connect} con ssh ${USER}@${ip_to_connect} -p ${PORT} ..."
exec ssh ${SSH_OPTS} -p "${PORT}" "${USER}@${ip_to_connect}"
