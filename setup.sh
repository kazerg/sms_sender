#!/bin/bash

clear

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}"
echo "███████╗███╗   ███╗███████╗    ███████╗███████╗███╗   ██╗██████╗ ███████╗██████╗ "
echo "██╔════╝████╗ ████║██╔════╝    ██╔════╝██╔════╝████╗  ██║██╔══██╗██╔════╝██╔══██╗"
echo "███████╗██╔████╔██║███████╗    ███████╗█████╗  ██╔██╗ ██║██║  ██║█████╗  ██████╔╝"
echo "╚════██║██║╚██╔╝██║╚════██║    ╚════██║██╔══╝  ██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗"
echo "███████║██║ ╚═╝ ██║███████║    ███████║███████╗██║ ╚████║██████╔╝███████╗██║  ██║"
echo "╚══════╝╚═╝     ╚═╝╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"

echo -e "${YELLOW}==== SMS Sender Project Setup ====${NC}"

echo "[*] Checking dependencies..."
REQUIRED_PKGS=("jq" "curl" "python3" "pip")
for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! command -v $pkg &> /dev/null; then
        echo -e "${RED}[-] $pkg not found. Installing...${NC}"
        sudo apt-get update && sudo apt-get install -y $pkg
    else
        echo -e "${GREEN}[+] $pkg already installed.${NC}"
    fi
done

# Python dotenv dependency
pip install python-dotenv &> /dev/null

if [ ! -f ".env" ]; then
    echo -e "${YELLOW}[*] Creating .env file...${NC}"
    read -p "Enter your API key: " api_key
    echo "API_KEY=$api_key" > .env
    echo -e "${GREEN}[+] .env file created.${NC}"
else
    echo -e "${GREEN}[+] .env already exists.${NC}"
fi

chmod +x bash/send_sms.sh
echo -e "${GREEN}[+] Bash script is now executable.${NC}"

echo -e "${YELLOW}[*] Setup complete. You can now run your scripts.${NC}"
