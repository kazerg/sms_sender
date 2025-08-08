#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo "🔐 Primera vez: necesitas ingresar tu API Key de Gateway360."
    read -s -p "Introduce tu API Key: " API_KEY
    echo
    echo "G360_API_KEY=$API_KEY" > "$ENV_FILE"
    source "$ENV_FILE"
fi

echo "====== Envío de SMS (Bash Gateway360) ======"
echo "1. Enviar SMS personalizado"
echo "2. Enviar mensaje rápido"
read -p "Selecciona una opción (1/2): " opcion

read -p "📞 Número destino (ej. 34623039784): " numero
read -p "🏢 Remitente (ej. SABADELL): " remitente

if [ "$opcion" == "1" ]; then
    read -p "💬 Mensaje: " mensaje
    read -p "🔗 Enlace (dejar vacío si no aplica): " enlace
else
    mensaje="Mensaje recibido correctamente desde el remitente $remitente."
    enlace=""
fi

send_at=$(date '+%Y-%m-%d %H:%M:%S')
callback_url="http://yourserver.com/callback/script"

json_payload="{"api_key":"$G360_API_KEY","report_url":"$callback_url","concat":1,"messages":[{"from":"$remitente","to":"$numero","text":"$mensaje","send_at":"$send_at"}]}"

if [ -n "$enlace" ]; then
    url="https://api.gateway360.com/api/3.0/sms/send-link"
    json_payload=$(echo "$json_payload" | jq --arg link "$enlace" '. + {link: $link}')
else
    url="https://api.gateway360.com/api/3.0/sms/send"
fi

echo "📝 JSON a enviar:"
echo "$json_payload" | jq

read -p "¿Enviar SMS? (s/n): " confirmacion
if [[ "$confirmacion" != "s" ]]; then
    echo "🚫 Envío cancelado."
    exit
fi

echo "📡 Enviando..."
respuesta=$(curl -s -X POST "$url" -H "Content-Type: application/json" -d "$json_payload")
echo "📬 Respuesta:"
echo "$respuesta"
