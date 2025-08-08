import os
import json
from datetime import datetime
from pathlib import Path
from dotenv import load_dotenv
import requests

env_path = Path(__file__).parent / '.env'
if not env_path.exists():
    api_key = input("🔐 Ingresa tu API Key de Gateway360: ").strip()
    with open(env_path, 'w') as f:
        f.write(f'G360_API_KEY={api_key}')
    print("✅ API Key guardada en .env")

load_dotenv(env_path)
API_KEY = os.getenv("G360_API_KEY")

if not API_KEY:
    print("❌ Error cargando API Key.")
    exit(1)

print("====== Envío de SMS (Python Gateway360) ======")
print("1. Enviar SMS personalizado")
print("2. Enviar mensaje rápido")
opcion = input("Selecciona una opción (1/2): ")

numero = input("📞 Número destino (ej. 34623039784): ").strip()
remitente = input("🏢 Remitente (ej. SABADELL): ").strip()

if opcion == "1":
    mensaje = input("💬 Mensaje (puedes usar {LINK}): ").strip()
    enlace = input("🔗 Enlace (dejar vacío si no aplica): ").strip()
else:
    mensaje = f"Mensaje recibido correctamente desde el remitente {remitente}."
    enlace = ""

SEND_AT = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
CALLBACK_URL = "http://yourserver.com/callback/script"

payload = {
    "api_key": API_KEY,
    "report_url": CALLBACK_URL,
    "concat": 1,
    "messages": [{
        "from": remitente,
        "to": numero,
        "text": mensaje,
        "send_at": SEND_AT
    }]
}

if enlace:
    payload["link"] = enlace
    url = "https://api.gateway360.com/api/3.0/sms/send-link"
else:
    url = "https://api.gateway360.com/api/3.0/sms/send"

print("\n📝 JSON a enviar:")
print(json.dumps(payload, indent=2))

confirm = input("¿Enviar SMS? (s/n): ")
if confirm.lower() != 's':
    print("🚫 Envío cancelado.")
    exit()

print("📡 Enviando...")
res = requests.post(url, json=payload, headers={"Content-Type": "application/json"})
print("📬 Respuesta:", res.status_code)
print(res.text)
