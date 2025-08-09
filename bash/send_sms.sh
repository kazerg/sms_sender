#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

source .env

if [ -z "$API_KEY" ]; then
    echo -e "\a${RED}API key not found. Please run setup.sh first.${NC}"
    exit 1
fi

echo "Choose language / Elige idioma:"
echo "1) English"
echo "2) Español"
read -p "Option: " lang
clear

case $lang in
  2)
    MSG_MENU="Selecciona una opción:"
    MSG_OPT1="Enviar SMS con enlace"
    MSG_OPT2="Enviar SMS de confirmación"
    MSG_ERR="Opción inválida"
    MSG_DONE="Solicitud enviada"
    ;;
  *)
    MSG_MENU="Choose an option:"
    MSG_OPT1="Send SMS with link"
    MSG_OPT2="Send confirmation SMS"
    MSG_ERR="Invalid option"
    MSG_DONE="Request sent"
    ;;
esac

echo -e "\a${YELLOW}$MSG_MENU${NC}"
echo "1) $MSG_OPT1"
echo "2) $MSG_OPT2"
read -p "Option: " option

case $option in
    1)
        read -p "Enter destination number: " number
        read -p "Enter sender name: " sender
        read -p "Enter message: " message
        read -p "Enter link: " link
        curl -X POST \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        -d "{
            \"api_key\":\"$API_KEY\",
            \"report_url\":\"http://yourserver.com/callback/script\",
            \"link\":\"$link\",
            \"concat\":1,
            \"messages\":[{\"from\":\"$sender\",\"to\":\"$number\",\"text\":\"$message\"}]
        }" \
        https://api.gateway360.com/api/3.0/sms/send-link
        ;;
    2)
        read -p "Enter destination number: " number
        read -p "Enter sender name: " sender
        message="Mensaje recibido correctamente desde el remitente $sender"
        curl -X POST \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        -d "{
            \"api_key\":\"$API_KEY\",
            \"concat\":1,
            \"messages\":[{\"from\":\"$sender\",\"to\":\"$number\",\"text\":\"$message\"}]
        }" \
        https://api.gateway360.com/api/3.0/sms/send
        ;;
    *)
        echo -e "\a${RED}$MSG_ERR${NC}"
        exit 1
        ;;
esac

echo -e "\a${GREEN}$MSG_DONE${NC}"
