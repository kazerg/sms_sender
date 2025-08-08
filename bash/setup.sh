#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"
GITIGNORE_FILE="$SCRIPT_DIR/.gitignore"
SMS_SCRIPT="$SCRIPT_DIR/send_sms.sh"

echo "📦 Iniciando instalación de SMS Sender (versión Bash)..."

if [ -f "$ENV_FILE" ]; then
  echo "✅ API Key ya configurada en .env"
else
  echo "🔐 Primera vez: necesitas ingresar tu API Key de Gateway360."
  read -s -p "Introduce tu API Key: " API_KEY
  echo
  if [ -z "$API_KEY" ]; then
    echo "❌ No se proporcionó API Key. Abortando."
    exit 1
  fi
  echo "G360_API_KEY=$API_KEY" > "$ENV_FILE"
  echo "✅ .env creado con tu API Key."
fi

if [ ! -f "$GITIGNORE_FILE" ]; then
  echo ".env" > "$GITIGNORE_FILE"
  echo "✅ .gitignore creado para ocultar .env"
fi

chmod +x "$SMS_SCRIPT"
echo "✅ Permisos aplicados a send_sms.sh"

if ! command -v curl &> /dev/null; then
  echo "⚠️ curl no está instalado. Intentando instalar..."
  sudo apt update && sudo apt install -y curl
else
  echo "✅ curl ya está instalado."
fi

read -p "❓ ¿Deseas crear el alias 'enviar_sms'? (s/n): " alias_resp
if [[ "$alias_resp" == "s" ]]; then
  SHELL_RC="$HOME/.bashrc"
  echo "alias enviar_sms='$SMS_SCRIPT'" >> "$SHELL_RC"
  echo "✅ Alias creado. Ejecuta 'source ~/.bashrc' para activarlo o reinicia terminal."
fi

echo -e "
🎉 Instalación completada. Ejecuta './send_sms.sh' para empezar."
