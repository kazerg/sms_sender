import os
import json
import requests
from dotenv import load_dotenv

# Cargar .env
env_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), ".env")
if not os.path.exists(env_path):
    print("Error: .env file not found. Please run setup.sh first.")
    exit(1)

load_dotenv(dotenv_path=env_path)

API_KEY = os.getenv("API_KEY")
if not API_KEY:
    print("API_KEY is missing in .env.")
    exit(1)

print("Choose an option:")
print("1) Send SMS with link")
print("2) Send confirmation SMS")
option = input("Option: ")

if option == "1":
    number = input("Enter destination number: ")
    sender = input("Enter sender name: ")
    message = input("Enter message: ")
    link = input("Enter link: ")
    payload = {
        "api_key": API_KEY,
        "report_url": "http://yourserver.com/callback/script",
        "link": link,
        "concat": 1,
        "messages": [{"from": sender, "to": number, "text": message}]
    }
    url = "https://api.gateway360.com/api/3.0/sms/send-link"

elif option == "2":
    number = input("Enter destination number: ")
    sender = input("Enter sender name: ")
    message = f"Mensaje recibido correctamente desde el remitente {sender}"
    payload = {
        "api_key": API_KEY,
        "concat": 1,
        "messages": [{"from": sender, "to": number, "text": message}]
    }
    url = "https://api.gateway360.com/api/3.0/sms/send"

else:
    print("Invalid option.")
    exit(1)

response = requests.post(url, headers={
    "Content-Type": "application/json",
    "Accept": "application/json"
}, data=json.dumps(payload))

print(response.text)
