#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

LOG_FILE="setup.log"

echo -e "${YELLOW}"
echo "███████╗███╗   ███╗███████╗    ███████╗███████╗███╗   ██╗██████╗ ███████╗██████╗ "
echo "██╔════╝████╗ ████║██╔════╝    ██╔════╝██╔════╝████╗  ██║██╔══██╗██╔════╝██╔══██╗"
echo "█████╗  ██╔████╔██║█████╗      ███████╗█████╗  ██╔██╗ ██║██║  ██║█████╗  ██████╔╝"
echo "██╔══╝  ██║╚██╔╝██║██╔══╝      ╚════██║██╔══╝  ██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗"
echo "███████╗██║ ╚═╝ ██║███████╗    ███████║███████╗██║ ╚████║██████╔╝███████╗██║  ██║"
echo "╚══════╝╚═╝     ╚═╝╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"

# Language selection
echo "Choose language / Elige idioma:"
echo "1) English"
echo "2) Español"
read -p "Option: " lang
clear

case $lang in
  2)
    MSG_CHECK="[ES] Verificando dependencias..."
    MSG_MISSING="[ES] no encontrado. Instalando..."
    MSG_INSTALLED="[ES] ya está instalado."
    MSG_API="[ES] Ingresando clave API..."
    MSG_DONE="[ES] Instalación completada."
    MSG_SAVED="[ES] Clave API guardada."
    ;;
  *)
    MSG_CHECK="[EN] Checking dependencies..."
    MSG_MISSING="[EN] not found. Installing..."
    MSG_INSTALLED="[EN] already installed."
    MSG_API="[EN] Setting up API key..."
    MSG_DONE="[EN] Installation complete."
    MSG_SAVED="[EN] API key saved."
    ;;
esac

echo -e "${YELLOW}${MSG_CHECK}${NC}"
REQUIRED_PKGS=("jq" "curl" "python3" "pip")
for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! command -v $pkg &> /dev/null; then
        echo -e "${RED}[-] $pkg ${MSG_MISSING}${NC}" | tee -a "$LOG_FILE"
        sudo apt-get update && sudo apt-get install -y $pkg
    else
        echo -e "${GREEN}[+] $pkg ${MSG_INSTALLED}${NC}" | tee -a "$LOG_FILE"
    fi
done

if [ ! -f ".env" ]; then
    echo -e "${YELLOW}${MSG_API}${NC}"
    read -p "API Key: " api_key
    echo "API_KEY=$api_key" > .env
    echo -e "${GREEN}${MSG_SAVED}${NC}" | tee -a "$LOG_FILE"
else
    echo -e "${GREEN}[+] .env already exists. Skipping.${NC}" | tee -a "$LOG_FILE"
fi

chmod +x bash/send_sms.sh
echo -e "\a${GREEN}[+] Bash script is now executable.${NC}" | tee -a "$LOG_FILE"
echo -e "\a${YELLOW}${MSG_DONE}${NC}" | tee -a "$LOG_FILE"
