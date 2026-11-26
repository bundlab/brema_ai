# 🤖 BremaAI

<p align="center">
  <img src="frontend/assets/icon/icon.png" alt="BremaAI Logo" width="150"/>
</p>

<h3 align="center">A Modern, Cross-Platform AI Assistant</h3>

<p align="center">
  An open-source AI chat application built with
  <strong>Flutter</strong>, <strong>FastAPI</strong>, and <strong>Ollama</strong>.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Frontend-Flutter-02569B?logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Backend-FastAPI-009688?logo=fastapi&logoColor=white" alt="FastAPI"/>
  <img src="https://img.shields.io/badge/Python-3.12+-3776AB?logo=python&logoColor=white" alt="Python"/>
  <img src="https://img.shields.io/badge/AI-Ollama-black?logo=ollama&logoColor=white" alt="Ollama"/>
  <img src="https://img.shields.io/badge/Model-Llama%203.2%201B-blue" alt="Llama 3.2"/>
  <img src="https://img.shields.io/github/license/bundlab/brema_ai" alt="License"/>
  <img src="https://img.shields.io/github/stars/bundlab/brema_ai" alt="GitHub Stars"/>
</p>

---

## 📖 Overview

**BremaAI** is an open-source, modular AI assistant designed to provide an intuitive conversational experience across desktop, web, and mobile platforms.

Built with Flutter and FastAPI, BremaAI separates its user interface from its AI processing layer, making the application easier to maintain, extend, and integrate with different AI providers.

The application currently uses **Ollama** to run local language models, allowing users to interact with AI without depending on external cloud AI APIs.

The long-term vision is to build an extensible AI platform that supports local inference, cloud-based AI services, multimodal interactions, and eventually a custom C++ AI engine.

## ✨ Features

### Implemented

- ✅ Modern Flutter chat interface.
- ✅ FastAPI REST backend.
- ✅ Modular AI provider architecture.
- ✅ Local AI inference using Ollama.
- ✅ Llama 3.2 1B model integration.
- ✅ HTTP communication between Flutter and FastAPI.
- ✅ Environment-based backend configuration.
- ✅ Local conversation history persistence.
- ✅ Create and manage multiple conversations.
- ✅ Search conversations by title or message content.
- ✅ Rename conversations.
- ✅ Delete conversations with confirmation.
- ✅ Markdown rendering for AI responses.
- ✅ Copy assistant responses.
- ✅ Selectable message text.
- ✅ Loading indicators and error handling.
- ✅ Responsive sidebar and chat interface.

### Planned

- 💬 Streaming AI responses.
- 🧠 Conversation-aware AI memory and context management.
- 🤖 Multiple local model selection.
- ☁️ Additional cloud AI provider integrations.
- 🖼️ Image understanding and analysis.
- 📄 PDF and document analysis.
- 🎤 Voice input.
- 🔊 Text-to-speech.
- 📎 File attachments and drag-and-drop support.
- ⚙️ Application settings.
- 🌙 Light and dark theme customization.
- 📱 Android and iOS support.
- 🔐 User authentication.
- ☁️ Cloud synchronization.
- ⚡ Custom C++ AI inference engine.
- 🚀 CUDA acceleration.

---

## 🏗 Architecture

BremaAI follows a modular frontend-backend architecture.

```text
                   Flutter Frontend
                          |
                          |
                          v
                    FastAPI Backend
                          |
                          |
                          v
                   AI Provider Router
                          |
                +---------+---------+
                |         |         |
                v         v         v
              Mock      Ollama    Gemini
                         |          |
                         v          v
                    Local Model  Cloud AI
                         |
                         v
                    Llama 3.2 1B

                  Future Integrations
                          |
                  +-------+-------+
                  |               |
                  v               v
                OpenAI         C++ Engine
```

### Frontend — Flutter

The frontend is responsible for:

- User interface and interaction.
- Chat message rendering.
- Conversation management.
- Local conversation persistence.
- Communication with the backend API.
- Responsive desktop and web layouts.

### Backend — FastAPI

The backend handles:

- REST API endpoints.
- Request validation.
- AI provider selection.
- Communication with local and cloud AI services.
- Response processing.
- Error handling.

### AI Layer

The AI provider router provides a unified interface for connecting different AI services without requiring major changes to the Flutter frontend.

### Local AI — Ollama

Ollama provides the local inference environment.

The currently configured model is:

```text
llama3.2:1b
```

The model runs locally through the Ollama API.

---

## 📂 Project Structure

```text
brema_ai/
│
├── backend/                       # FastAPI backend
│   ├── app/
│   │   ├── api/
│   │   │   ├── chat.py
│   │   │   └── health.py
│   │   ├── core/
│   │   │   ├── config.py
│   │   │   └── logging.py
│   │   ├── middleware/
│   │   │   └── exception_handler.py
│   │   ├── schemas/
│   │   │   └── chat.py
│   │   ├── services/
│   │   │   ├── ai_router.py
│   │   │   ├── ollama_service.py
│   │   │   ├── gemini_service.py
│   │   │   └── mock_service.py
│   │   └── main.py
│   ├── .env.example
│   └── requirements.txt
│
├── frontend/                      # Active Flutter application
│   ├── lib/
│   │   ├── config/
│   │   ├── core/
│   │   ├── models/
│   │   ├── screens/
│   │   ├── services/
│   │   ├── theme/
│   │   ├── widgets/
│   │   └── main.dart
│   ├── assets/
│   │   ├── icon/
│   │   └── images/
│   ├── test/
│   ├── android/
│   ├── ios/
│   ├── linux/
│   ├── macos/
│   ├── web/
│   ├── windows/
│   ├── pubspec.yaml
│   └── pubspec.lock
│
├── cpp_engine/                    # Future C++ engine
├── docker/                        # Future Docker configuration
├── docs/                          # Project documentation
│
├── android/                       # Original Flutter scaffold
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
├── test/
│
├── pubspec.yaml                   # Original Flutter package
├── pubspec.lock
├── analysis_options.yaml
├── .gitignore
├── LICENSE
└── README.md
```

**Important:** The active Flutter application is located in `frontend/`. The root-level Flutter files belong to the original project scaffold and are not used by the current frontend-backend workflow.

The `cpp_engine/` and `docker/` directories are reserved for future development.

---

## 🚀 Getting Started

### Prerequisites

Install the following tools before running BremaAI:

- Git
- Python 3.12+
- Flutter SDK
- Dart SDK (included with Flutter)
- Ollama
- A supported Ollama language model

### 1. Clone the Repository

```bash
git clone https://github.com/bundlab/brema_ai.git

cd brema_ai
```

---

## 🧠 Setting Up Ollama

BremaAI currently uses Ollama for local AI inference.

### Install Ollama

On Linux:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Check the installation:

```bash
ollama --version
```

### Download the AI Model

Pull the Llama 3.2 1B model:

```bash
ollama pull llama3.2:1b
```

Verify the downloaded model:

```bash
ollama list
```

### Test the Model

```bash
ollama run llama3.2:1b
```

You can now interact with the model directly from your terminal.

Exit the interactive session when finished.

### Verify the Ollama API

```bash
curl http://127.0.0.1:11434/api/tags
```

Ollama normally runs as a background service on Linux after installation.

---

## ⚡ Backend Setup

### 1. Navigate to the Backend

From the repository root:

```bash
cd backend
```

### 2. Create a Virtual Environment

```bash
python3 -m venv venv
```

### 3. Activate the Environment

```bash
source venv/bin/activate
```

### 4. Install Dependencies

```bash
pip install --upgrade pip

pip install -r requirements.txt
```

### 5. Configure Environment Variables

Create your local environment file:

```bash
cp .env.example .env
```

Configure `backend/.env`:

```env
HOST=127.0.0.1
PORT=8010

DEFAULT_PROVIDER=ollama

OLLAMA_URL=http://127.0.0.1:11434
OLLAMA_MODEL=llama3.2:1b

GEMINI_API_KEY=
OPENAI_API_KEY=
```

**Important:** Never commit your actual `.env` file or expose private API keys.

### 6. Start the Backend

From the `backend/` directory:

```bash
uvicorn app.main:app --reload --host 127.0.0.1 --port 8010
```

Backend URL:

```text
http://127.0.0.1:8010
```

API documentation:

```text
http://127.0.0.1:8010/docs
```

The backend also provides a health endpoint. Check the registered route in the FastAPI documentation to confirm its exact path.

Keep this terminal running.

---

## 🎨 Frontend Setup

Open another terminal.

### 1. Navigate to the Frontend

From the repository root:

```bash
cd frontend
```

### 2. Install Flutter Dependencies

```bash
flutter pub get
```

### 3. Verify the Application

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

### 4. Run BremaAI in Chrome

```bash
flutter run -d chrome --web-hostname localhost --web-port 8081
```

### Run on Linux Desktop

```bash
flutter run -d linux
```

**Note:** Keep the FastAPI backend and Ollama service running while using the application.

The frontend is configured to communicate with the backend at:

```text
http://127.0.0.1:8010
```

If you change the backend port or address, update the frontend API configuration accordingly.

---

## 🔌 AI Providers

BremaAI uses a provider-based architecture to support different AI services.

| Provider | Status |
|---|---|
| Mock AI | Available |
| Ollama | Integrated and tested |
| Llama 3.2 1B | Integrated and tested |
| Gemini | Integration present; further testing required |
| OpenAI | Planned |
| Custom C++ AI Engine | Future development |

### Provider Configuration

The active provider is configured in `backend/.env`.

Example:

```env
DEFAULT_PROVIDER=ollama
```

Other provider options depend on their implementation and configuration.

---

## 💾 Conversation Storage

BremaAI currently supports local conversation management.

Implemented functionality includes:

- Creating new conversations.
- Saving conversation history locally.
- Restoring saved conversations.
- Searching conversation titles and message content.
- Renaming conversations.
- Deleting conversations with confirmation.

Conversation history is stored locally by the Flutter application using Shared Preferences.

**Important:** Local conversation persistence is different from AI conversation memory. Previous messages are not yet automatically sent to the backend as context for subsequent AI responses. Conversation-aware AI memory is planned for a future release.

---

## 🛠 Technologies

### Frontend

- Flutter
- Dart
- Material 3
- HTTP
- Shared Preferences
- Flutter Markdown

### Backend

- Python
- FastAPI
- HTTPX
- Pydantic
- Uvicorn
- Python Dotenv

### Local AI

- Ollama
- Llama 3.2 1B

### Future Technologies

- C++
- CUDA
- Tensor and inference engines
- Additional cloud AI APIs

---

## 🗺 Roadmap

### Phase 1 — Foundation

- [x] Flutter application structure.
- [x] FastAPI backend.
- [x] Modular AI provider router.
- [x] Backend API communication.

### Phase 2 — Chat Experience

- [x] Modern chat interface.
- [x] Markdown response rendering.
- [x] Conversation history.
- [x] Conversation search.
- [x] Rename and delete conversations.

### Phase 3 — Local AI Integration

- [x] Ollama installation and configuration.
- [x] Llama 3.2 1B integration.
- [x] FastAPI-to-Ollama communication.
- [x] Extended AI response timeout.

### Phase 4 — Intelligent Conversations

- [ ] Conversation-aware memory.
- [ ] Context management.
- [ ] Streaming responses.
- [ ] Model selection.

### Phase 5 — Multimodal AI

- [ ] Image understanding.
- [ ] PDF and document analysis.
- [ ] Voice input and output.
- [ ] File attachments.

### Phase 6 — Advanced AI Infrastructure

- [ ] Custom C++ inference engine.
- [ ] CUDA acceleration.
- [ ] Performance optimization.
- [ ] Additional cloud AI providers.

### Phase 7 — Production Readiness

- [ ] Authentication.
- [ ] Cloud synchronization.
- [ ] Application settings.
- [ ] Mobile applications.
- [ ] Production deployment.

---

## 🐛 Troubleshooting

### Backend Connection Error

Ensure that FastAPI is running.

Test the backend:

```bash
curl http://127.0.0.1:8010/
```

If the backend is unavailable, restart it from the `backend/` directory.

### Ollama Connection Error

Check the Ollama service:

```bash
sudo systemctl status ollama
```

Check available models:

```bash
ollama list
```

Verify the Ollama API:

```bash
curl http://127.0.0.1:11434/api/tags
```

### AI Response Timeout

Local AI inference depends on available system resources, model size, and hardware performance.

BremaAI configures an extended HTTP response timeout to accommodate slower local model generation.

The extended timeout allows more time for responses; it does not increase the model's inference speed.

### Flutter Dependency Issues

Run:

```bash
cd frontend

flutter clean

flutter pub get
```

### Port Already in Use

Check whether the backend port is occupied:

```bash
sudo lsof -i :8010
```

Use the configured backend port consistently in both the FastAPI server and Flutter API configuration.

---

## 🤝 Contributing

Contributions are welcome!

If you would like to improve BremaAI:

1. Fork the repository.
2. Create a feature branch.
3. Implement your changes.
4. Run relevant tests.
5. Commit with a meaningful commit message.
6. Open a pull request.

Please ensure that your changes follow the existing project structure and coding conventions.

---

## 📄 License

BremaAI is released under the MIT License.

See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Abdullahi Bundi**

Software Engineer · AI Developer · Open Source Contributor

- GitHub: [@bundlab](https://github.com/bundlab)
- Repository: [github.com/bundlab/brema_ai](https://github.com/bundlab/brema_ai)

---

<p align="center">
  Built with ❤️ using Flutter, FastAPI, Ollama, and Open Source Technologies.
</p>

<p align="center">
  <strong>BremaAI — Building the Future of Local AI.</strong>
</p>