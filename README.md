# Customer Service Chatbot

Customer Service Chatbot powered by FastAPI, PostgreSQL, and Ollama LLM.

[![Python](https://img.shields.io/badge/Python-3.11-3776AB?style=flat&logo=python&logoColor=white)](https://www.python.org/downloads/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.104.1-009688?style=flat&logo=fastapi&logoColor=white)](https://github.com/tiangolo/fastapi)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?style=flat&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Ollama](https://img.shields.io/badge/Ollama-latest-6F42C1?style=flat&logo=ghost&logoColor=white)](https://ollama.com/)

---

## Project Overview

This service provides a conversational API for customer support and sales assistance, backed by:
- A PostgreSQL database for products, users, warranty (garansi), and chat history
- An Ollama-hosted LLM (default: `llama3.2:3b`) with tool calling for DB lookups
- Clean separation of routes, schemas, services, and utils



---

## Minimum Requirements (Local Environment)

- Python 3.11+
- Docker and Docker Compose
- 2 GB+ free RAM for base usage (more is better for LLM)
- Internet access for pulling Docker images and LLM model (first run)

Optional (for GPU inference):
- NVIDIA GPU + NVIDIA drivers + NVIDIA Container Toolkit

---

## Installation (Two Options)

### Option A: Run via Docker Compose (recommended)

1) Clone the repository
```bash
git clone https://github.com/your-org/cs-chatbot.git
cd cs-chatbot/cs-chatbot
```

2) Start services
```bash
docker-compose up --build -d
```

3) Stop services
```bash
docker-compose down
```

Notes:
- PostgreSQL is auto-initialized on first run using `server/database/full_dump.sql`
- Ollama service starts and exposes `http://localhost:11434`
- App is available at `http://localhost:8000` and Swagger UI at `/docs`

GPU users: if your environment supports NVIDIA GPU, you can enable the GPU compose (or `deploy` block) and set `NUM_GPU`, otherwise keep CPU mode. In WSL environments without GPU passthrough, use CPU mode (the default compose already does this).

### Option B: Use Prebuilt Image

You can pull the prebuilt application image:
```bash
docker pull ghcr.io/raffelprama/cs-chatbot:0.0.1
```
Integrate it in your compose or run with the required env vars mounted.

---

## Local Development (without Docker)

Project structure:
```text
cs-chatbot/
├── docker-compose.yaml          # Orchestrates app, Postgres, and Ollama
├── dockerfile                   # Application container image
├── main.py                      # FastAPI app entrypoint
├── requirements.txt             # Pinned dependencies
├── README.md                    # Documentation
├── logs/                        # Runtime logs (mounted in container)
└── server/                      # Application code
    ├── database/
    │   ├── db.py                # PostgreSQL connection manager
    │   └── full_dump.sql        # Initial schema + seed data
    ├── routes/                  # FastAPI routes
    │   ├── __init__.py
    │   ├── chat.py              # /chat/completions endpoint
    │   ├── history_db.py        # /history, /all, /head-5
    │   └── model_db.py          # /product, /users, /user, /garansi
    ├── schemas/                 # Pydantic DTOs
    │   ├── __init__.py
    │   ├── chat_schema.py
    │   ├── history_db_shacme.py
    │   └── model_db_schema.py
    ├── service/                 # Business logic layer
    │   ├── __init__.py
    │   ├── chat_service.py
    │   ├── history_db_service.py
    │   ├── model_db_service.py
    │   └── ollama_service.py    # LLM + tool calling
    └── utils/                   # Shared helpers
        ├── __init__.py
        ├── model.py             # Facades for DB queries used by LLM
        └── tools.py             # Tool-call registry exposed to LLM
```

1) Create virtual environment and install dependencies
```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\\Scripts\\activate
pip install -r requirements.txt
```

2) Ensure PostgreSQL is running locally and set env vars (example)
```env
DB_HOST=localhost
DB_NAME=chatbot
DB_USER=myuser
DB_PASSWORD=mypassword
DB_PORT=5432
OLLAMA_HOST=http://localhost:11434
APP_NAME=CS-Chatbot
HOST=0.0.0.0
PORT=8000
```

3) Run the app
```python
python3 main.py
```

---

## Database Design

The included `server/database/full_dump.sql` initializes four tables:
### Product
| Column Name | Type   | Notes / Constraints |
|-------------|--------|-------------------|
| id          | uuid   | PK |
| product     | varchar| - |
| quantity    | int    | - |
| positive    | text   | - |
| negative    | text   | - |
| price       | int    | - |

### Users
| Column Name | Type   | Notes / Constraints |
|-------------|--------|-------------------|
| user_id     | varchar| PK |
| id_data     | uuid   | FK → `garansi.garansi_id` |
| product     | varchar| - |
| status      | varchar| - |
| estimasi    | varchar| - |

### Garansi
| Column Name        | Type | Notes / Constraints |
|-------------------|------|-------------------|
| garansi_id         | uuid | PK |
| garansi_description| text | unique |

### Chat History
| Column Name    | Type       | Notes / Constraints |
|----------------|-----------|-------------------|
| id             | uuid      | PK |
| user_id        | uuid      | - |
| message_text   | text      | - |
| message_role   | varchar   | user \| assistant \| tool |
| timestamp      | timestamptz | default now |

Auto-loading on first run is handled by mounting `full_dump.sql` to `/docker-entrypoint-initdb.d/01-init.sql` in the Postgres container.

---

## Libraries & Frameworks Used

- FastAPI (web framework)
- Uvicorn (ASGI server)
- Pydantic (schemas)
- Psycopg2 (PostgreSQL client)
- python-dotenv (env management)
- Requests (HTTP client)
- Ollama (local LLM runtime)
- Tenacity, Packaging, Schedule (utilities)

See `requirements.txt` for pinned versions.

---

## LLM Model

- Runtime: Ollama
- Default model: `llama3.2:3b`
- Configured in `server/service/ollama_service.py`
- The service provides tool calling to fetch user and warranty data

If the model is not yet pulled, see Troubleshooting below.

---

## Supported Questions (Examples)

Examples the bot can answer:
- Product catalog questions (e.g., available cameras, pros/cons, prices)
- Order/user status (via tool call `get_user` when user_id is provided)
- Warranty/garansi details (via tool call `get_garansi`)
- Short general questions with simple reasoning

The bot is guided to be concise, greet at start, and thank at the end.

---

## Tool Calls Available

Declared in `server/utils/tools.py` and exposed to the LLM:
- `get_user(user_id: str)` → returns user/order information
- `get_garansi()` → returns warranty information

These tools are automatically suggested to the LLM based on the prompt context.

---

## API Endpoints

## API Endpoints

| Category | Method | Endpoint | Description | Query Parameters |
|----------|--------|---------|-------------|-----------------|
| **Chat** | POST   | /chat/completions | Chat with the bot | prompt, user_id |
| **Models** | GET   | /product | List products | - |
| **Models** | GET   | /users | List users | - |
| **Models** | GET   | /user | Single user | user_id |
| **Models** | GET   | /garansi | List warranties | - |
| **History** | POST  | /history | Save chat history entry | - |
| **History** | GET   | /all | All chat history | - |
| **History** | GET   | /head-5 | Last N messages for a user | user_id, count |
| **Default** | GET  | /health | Service health | - |


Open Swagger UI at `http://localhost:8000/docs`.

---

## Deployment with Docker Compose

The main compose file (`docker-compose.yaml`) includes three services:

- `postgres`: PostgreSQL database
  - Mounts `server/database/full_dump.sql` for first-time initialization
  - Health-checked with `pg_isready`

- `ollama`: LLM runtime
  - Exposes port `11434`
  - CPU by default; GPU section is commented to avoid WSL/NVIDIA issues

- `app`: FastAPI service
  - Exposes port `8000`
  - Depends on `postgres` health and `ollama` start

Basic commands:
```bash
docker-compose up --build -d   # start
docker-compose down            # stop
docker-compose logs -f         # tail logs
```

Environment variables passed to `app` include DB and Ollama host; see `docker-compose.yaml` for details.

---

## Troubleshooting

### 1) Database tables do not exist

Symptoms: API logs show errors like `relation "product" does not exist`.

Cause: The Postgres data volume already existed and skipped initialization, or the SQL file did not run.

Fix:
```bash
docker-compose down -v   # WARNING: removes database volume
docker-compose up --build -d
# Wait for postgres to initialize; check logs
docker-compose logs postgres
```

### 2) Ollama model not available yet

If the Ollama container starts without the model pulled, the first chats may fail. You can enter the container and pull the model:

```bash
docker ps
docker exec -it cs-chatbot-ollama /bin/bash

# Inside the container
ollama list                 # if empty, no models yet
ollama pull llama3.2:3b     # pull the model used by the app
exit
```

Then retry your request.

### 3) NVIDIA GPU errors on WSL

If you see `nvidia-container-cli` errors, your environment does not have GPU passthrough. Use CPU mode (default compose already disables GPU). Do not enable the `deploy.resources.reservations.devices` block unless you have NVIDIA Container Toolkit configured.

---

## Security & Logging

- Logs are written to `./logs/<APP_NAME>.log` and the console
- CORS is open (`*`) by default for ease of testing; scope it down for production
- Never commit real secrets; use environment variables or secret managers

---

## License

MIT License.
