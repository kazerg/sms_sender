import os
import json
import requests

# Cargar API key desde .env
if not os.path.exists(".env"):
    print("API key not found. Please run setup.sh first.")
    exit()

with open(".env") as f:
    for line in f:
        if line.startswith("API_KEY"):
            API_KEY = line.strip().split("=")[1]

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
    exit()

response = requests.post(url, headers={"Content-Type": "application/json", "Accept": "application/json"}, data=json.dumps(payload))
print(response.text)
