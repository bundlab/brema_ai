# 🤖 BremaAI

<p align="center">
  <img src="frontend/assets/icon/icon.png" alt="Brema AI Logo" width="150"/>
</p>

<h3 align="center">
A Modern, Cross-Platform AI Assistant
</h3>

<p align="center">
Built with <strong>Flutter</strong>, <strong>FastAPI</strong>, and designed for future <strong>C++ AI Engine</strong> integration.
</p>

<p align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![FastAPI](https://img.shields.io/badge/FastAPI-Latest-009688?logo=fastapi)
![Python](https://img.shields.io/badge/Python-3.12+-3776AB?logo=python)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Windows%20%7C%20macOS-lightgrey)

</p>

---

## 📖 Overview

Brema AI is an open-source, modular AI assistant designed to deliver a fast, secure, and extensible conversational experience across desktop, mobile, and web platforms.

Unlike traditional AI clients that depend on a single provider, Brema AI uses a provider-based architecture, allowing seamless switching between local and cloud AI models without modifying the frontend.

The project is built with:

- 🎨 Flutter (Cross-platform UI)
- ⚡ FastAPI (Backend API)
- 🧠 Provider-based AI Router
- 🖥️ Local AI support (Ollama)
- ☁️ Cloud AI support (Gemini, OpenAI)
- 🚀 Future C++/CUDA AI Engine integration

---

# ✨ Features

## Current

- ✅ Flutter Desktop Application
- ✅ FastAPI REST Backend
- ✅ Modular AI Router
- ✅ Mock AI Provider
- ✅ Provider Switching Architecture
- ✅ Environment-based Configuration
- ✅ Modern Chat UI
- ✅ RESTful API
- ✅ Markdown-ready Responses

---

## Planned

- 💬 Streaming AI Responses
- 📂 Multiple Conversations
- 📄 PDF & Document Analysis
- 🖼️ Image Understanding
- 🎤 Voice Input
- 🔊 Text-to-Speech
- 📎 Drag & Drop Attachments
- 🌐 Web Support
- 📱 Android & iOS
- 🧠 Memory & Context Management
- ⚙️ Settings Page
- 🌙 Light/Dark Themes
- 💾 Local Chat History
- 🔐 Authentication
- 🤖 Local C++ AI Engine
- 🚀 CUDA Acceleration

---

# 🏗 Project Architecture

```
                 Flutter Frontend
                        │
                        ▼
                 FastAPI Backend
                        │
                 AI Provider Router
                        │
      ┌───────────┬──────────────┬──────────────┐
      ▼           ▼              ▼              ▼
   Mock AI     Ollama         Gemini        OpenAI
                                                │
                                                ▼
                                       Future C++ AI Engine
```

---

# 📂 Project Structure

```
brema_ai/

├── backend/
│   ├── app/
│   │   ├── api/
│   │   ├── core/
│   │   ├── models/
│   │   ├── services/
│   │   └── schemas/
│   │
│   ├── requirements.txt
│   └── .env.example
│
├── frontend/
│   ├── lib/
│   │   ├── models/
│   │   ├── screens/
│   │   ├── services/
│   │   ├── widgets/
│   │   └── main.dart
│   │
│   ├── assets/
│   └── pubspec.yaml
│
├── LICENSE
├── CONTRIBUTING.md
└── README.md
```

---

# 🚀 Getting Started

## Clone

```bash
git clone https://github.com/bundlab/brema_ai.git

cd brema_ai
```

---

# Backend

## Create Virtual Environment

```bash
cd backend

python3 -m venv venv

source venv/bin/activate
```

Install dependencies

```bash
pip install -r requirements.txt
```

Copy the environment file

```bash
cp .env.example .env
```

Run the server

```bash
uvicorn app.main:app --reload
```

Backend URL

```
http://127.0.0.1:8000
```

API Documentation

```
http://127.0.0.1:8000/docs
```

---

# Frontend

```bash
cd frontend

flutter pub get

flutter run
```

---

# AI Providers

Brema AI supports multiple providers through a unified interface.

| Provider | Status |
|----------|--------|
| Mock | ✅ |
| Ollama | 🚧 |
| Gemini | 🚧 |
| OpenAI | 🚧 |
| C++ AI Engine | 🔜 |

Provider selection is controlled using the `.env` configuration.

Example:

```env
DEFAULT_PROVIDER=mock
```

Future options:

```env
DEFAULT_PROVIDER=ollama
```

```env
DEFAULT_PROVIDER=gemini
```

```env
DEFAULT_PROVIDER=openai
```

---

# Technologies

## Frontend

- Flutter
- Dart
- Material 3

## Backend

- FastAPI
- Python
- HTTPX
- Pydantic

## Future AI

- Ollama
- Gemini
- OpenAI
- CUDA
- Tensor Engine
- C++

---

# Roadmap

### Phase 1

- Flutter Desktop
- FastAPI Backend
- Provider Router

### Phase 2

- Beautiful UI
- Markdown
- Streaming

### Phase 3

- Image Upload
- PDF Analysis
- Voice Support

### Phase 4

- Local AI
- CUDA
- C++ Engine

### Phase 5

- Enterprise Features
- Authentication
- Cloud Sync

---

# Contributing

Contributions are welcome.

Please read the **CONTRIBUTING.md** guide before submitting issues or pull requests.

---

# License

This project is licensed under the MIT License.

See the **LICENSE** file for details.

---

# Author

**Abdullahi Bundi**

Software Engineer • AI Developer • Open Source Contributor

GitHub

https://github.com/bundlab

---

<p align="center">

Made with ❤️ using Flutter, FastAPI, and Open Source Technologies.

</p>