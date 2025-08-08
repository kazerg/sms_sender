# 📡 SMS Sender (Gateway360) – Bash & Python CLI

**🇪🇸 Español** | **🇬🇧 English**

---

## 📌 Description

**🇪🇸**  
Scripts en **Bash** y **Python** para enviar SMS a través de la API de Gateway360. Incluyen instalación guiada por terminal y soporte para variables de entorno locales. Diseñado para ser usado fácilmente desde Kali NetHunter o cualquier terminal Linux.

**🇬🇧**  
**Bash** and **Python** scripts to send SMS via the Gateway360 API. Includes guided terminal installation and support for local environment variables. Designed for easy use from Kali NetHunter or any Linux terminal.

---

## 📂 Repository Structure

```
sms_sender/
│
├── bash/
│   ├── send_sms.sh       # Main Bash script
│   ├── setup.sh          # Guided setup for API key
│   └── .gitignore
│
├── python/
│   ├── send_sms.py       # Main Python script
│   ├── setup.sh          # Guided setup for API key
│   └── .gitignore
│
└── README.md
```

---

## 🚀 Installation

### 1️⃣ Clone the repository

```bash
git clone https://github.com/<your-username>/sms_sender.git
cd sms_sender
```

---

### 2️⃣ Install the Bash version

```bash
cd bash
chmod +x setup.sh send_sms.sh
./setup.sh
```

**Setup process:**
- Asks for your API Key (stored locally in `.env`).
- Prepares the environment for running `send_sms.sh`.

---

### 3️⃣ Install the Python version

**Requirements:** Python 3.x

```bash
cd ../python
chmod +x setup.sh send_sms.py
./setup.sh
```

**Setup process:**
- Asks for your API Key (stored locally in `.env`).
- Installs required dependencies automatically.

---

## 📲 Usage

### Bash

```bash
./send_sms.sh
```

Follow the interactive menu:
1. Send SMS with link.
2. Send SMS without link.
3. Exit.

---

### Python

```bash
python3 send_sms.py
```

Follow the interactive menu:
1. Send SMS with link.
2. Send SMS without link.
3. Exit.

---

## ⚠️ Notes

- The `.env` file is created locally inside each version folder.
- API Key is stored locally, **never upload it to GitHub**.
- Works with **Kali NetHunter**, Linux, and macOS.

---

## 📜 License

MIT License.
