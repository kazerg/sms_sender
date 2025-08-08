#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

echo "📦 Instalando dependencias para versión Python..."

if [ ! -f "$ENV_FILE" ]; then
  read -s -p "🔐 Ingresa tu API Key de Gateway360: " API_KEY
  echo
  echo "G360_API_KEY=$API_KEY" > "$ENV_FILE"
  echo "✅ .env creado."
fi

if ! command -v pip3 &> /dev/null; then
  echo "⚠️ pip3 no encontrado. Instalando..."
  sudo apt update && sudo apt install -y python3-pip
fi

pip3 install -q -U requests python-dotenv

echo "✅ Python ready. Ejecuta con: python3 send_sms.py"
