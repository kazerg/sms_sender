# 📡 SMS Sender (Gateway360) – Bash & Python CLI

Este repositorio contiene dos implementaciones (`bash` y `python`) para enviar SMS usando la API de [Gateway360](https://www.gateway360.com/). Diseñado para usarse fácilmente desde terminales como **Kali NetHunter**, scripts automatizados o herramientas educativas.

## 📦 Estructura

```
sms_sender/
├── bash/      → versión en bash
├── python/    → versión en python
```

## ⚙️ Instalación rápida

### Opción 1: Bash

```bash
cd bash
./setup.sh
```

### Opción 2: Python

```bash
cd python
./setup.sh
```

> El setup pedirá tu API Key la primera vez, y creará un archivo `.env` localmente para futuras ejecuciones.

## 🚀 Uso

Después del `setup`, simplemente ejecuta:

- En Bash: `./send_sms.sh` o `enviar_sms` (si activaste el alias)
- En Python: `python3 send_sms.py`

## 🔐 Seguridad

- Tu API Key se guarda localmente en `.env` (excluido por `.gitignore`)
- No se comparte al subir el repositorio.
