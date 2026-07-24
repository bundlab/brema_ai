<<<<<<< HEAD
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
=======
# BremaAI

![Frontend: Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?logo=flutter&logoColor=white) ![Backend: FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?logo=fastapi&logoColor=white) ![Issues](https://img.shields.io/github/issues/bundlab/brema_ai) ![Stars](https://img.shields.io/github/stars/bundlab/brema_ai) ![License](https://img.shields.io/github/license/bundlab/brema_ai)

A polished, desktop-first AI chat application built with Flutter (frontend) and FastAPI (backend), targeting Ubuntu 24.04 LTS. BremaAI delivers a fast, native-feeling chat experience powered by Google Generative AI (Gemini) and optimized for developer workflows: markdown rendering, syntax-highlighted code blocks, selectable text, and a minimal desktop UI.

---

Table of contents
- Features
- Architecture
- Preview
- Quick start
- Development
- Configuration
- Troubleshooting
- Contributing
- License
- Support

---

## Features

- High-performance AI responses (Gemini 2.5 Flash-Lite)
- Native Linux (Ubuntu) optimizations and desktop-friendly UI
- Beautiful Markdown rendering with syntax highlighting (Python, JavaScript, etc.)
- Selectable and copyable text for easy reuse of answers and code
- Lightweight, responsive UI built with Flutter
- Robust backend API built with FastAPI for low-latency, scalable requests

---

## Architecture

BremaAI is split into two main components:

- Frontend — Flutter (Dart)
  - Desktop-first UI, runnable on Linux using Flutter's linux target
  - Handles UI, local state, and rendering of Markdown & code blocks

- Backend — FastAPI (Python)
  - Exposes endpoints that proxy and manage requests to the chosen AI provider (Gemini)
  - Responsible for authentication, rate limiting, request batching, and any server-side business logic

This separation keeps the UI lightweight while enabling secure key management, caching, and scalable compute on the server side.

---

## Preview

Place screenshots in `assets/screenshots/` and they will render here. Example image placeholders:

![App main screen](assets/screenshots/screenshot-1.png)

![Conversation and code view](assets/screenshots/screenshot-2.png)

Tips:
- Use PNG or WebP images with a width of 1280px for best clarity on large displays.
- Commit images to `assets/screenshots/` using the filenames above or update the links below.

---

## Quick start

Prerequisites
- Flutter SDK (stable channel recommended)
- Python 3.10+ and pip
- Ubuntu 24.04 LTS (primary target for desktop builds)
- A valid API key for the configured AI provider (Gemini)

Run the backend (FastAPI)
1. Create a virtual environment and install dependencies

   python -m venv .venv
   source .venv/bin/activate
   pip install -r backend/requirements.txt

2. Start the FastAPI server (example)

   uvicorn backend.main:app --reload --host 0.0.0.0 --port 8000

Run the frontend (Flutter)
1. Fetch dependencies

   flutter pub get

2. Run the app on Linux

   flutter run -d linux --dart-define=API_URL=http://localhost:8000 --dart-define=API_KEY=YOUR_API_KEY_HERE

Notes
- Replace YOUR_API_KEY_HERE with your actual API key. For local development you can pass it via dart-define or configure the backend to read it from a secure environment variable.
- For production, keep API keys secret and manage them via a secrets manager or CI/CD environment variables.

---

## Development

- Recommended editors: Visual Studio Code, Android Studio, or IntelliJ IDEA.
- Use hot reload and hot restart for fast UI iteration.
- Project layout follows a conventional split:
  - backend/ — FastAPI server and API code
  - frontend/ — Flutter application (desktop target)

Useful commands
- flutter analyze — run static analysis
- flutter test — run tests (if available)
- flutter build linux — build a production Linux binary
- uvicorn backend.main:app --reload — run backend in development

---

## Configuration

The app uses two main configuration points:
- API_KEY — your AI provider key (used by backend or directly by the client if configured that way)
- API_URL — backend endpoint (e.g., http://localhost:8000)

Example local run:

   flutter run -d linux --dart-define=API_URL=http://localhost:8000 --dart-define=API_KEY=YOUR_API_KEY_HERE

Adjust the backend configuration in `backend/.env` or environment variables as needed.

---

## Troubleshooting

- If Flutter cannot target Linux, ensure desktop support is enabled and system dependencies are installed (see `flutter doctor`).
- If the backend returns errors, check the FastAPI logs and confirm your API key and provider quotas.
- CORS issues: if the frontend communicates directly to the backend, ensure CORS middleware is configured in FastAPI.

---

## Contributing

Contributions are welcome. Suggested workflow:
1. Fork the repository
2. Create a branch: `feature/<name>` or `fix/<issue>`
3. Commit with a clear message
4. Open a pull request describing the changes

Please include tests for any non-trivial backend logic and follow existing code style conventions.

---

## License

Add or update a LICENSE file in the repository root to make the project license explicit (e.g., MIT, Apache-2.0).

---

## Support & Contact

For bug reports or feature requests, open an issue in this repository. For direct maintainer contact, add a maintainer email or handle in this section.

---

Made with care — Bundlab
>>>>>>> origin/main
