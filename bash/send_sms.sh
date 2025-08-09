#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ENV_FILE="../.env"
source "$ENV_FILE"

if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}[!] .env file not found. Please run setup.sh first.${NC}"
    exit 1
fi

if [ -z "$API_KEY" ]; then
    echo -e "${RED}API key not found in .env.${NC}"
    exit 1
fi

echo -e "${YELLOW}Choose an option:${NC}"
echo "1) Send SMS with link"
echo "2) Send confirmation SMS"
read -p "Option: " option

case $option in
    1)
        read -p "Enter destination number (+34655555555): " number
        read -p "Enter sender name: " sender
        read -p "Enter message (Open the next link: {LINK}): " message
        read -p "Enter link (https://www.example.com): " link
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
        read -p "Enter destination number (+34655555555): " number
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
        echo -e "${RED}Invalid option.${NC}"
        ;;
esac
