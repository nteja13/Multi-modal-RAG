## 📋 Prerequisites

<img width="2240" height="906" alt="image" src="https://github.com/user-attachments/assets/7bda9440-f274-43bc-be7a-3931f30dc707" />


Before you start, make sure you have these installed:

- 🐍 **Python 3.10+** (check with `python --version`)
- 📦 **Poetry** (Python dependency manager)
- 🐳 **Docker** (for Redis and Supabase)
- 📘 **Node.js** (for Supabase CLI)
- 🍺 **Homebrew** (macOS only - for system dependencies)

## 🔧 Step 1: Install System Dependencies

### macOS

```bash
brew install poppler tesseract libmagic
```

### Linux (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install poppler-utils tesseract-ocr libmagic1
```

> ⚠️ **Note**: These are required for document processing (PDFs, images, etc.)

## 📦 Step 2: Install Python Dependencies

Install all Python packages using Poetry:

```bash
poetry install
```

## 🗄️ Step 3: Setup Supabase

### Initialize Supabase

```bash
npx supabase init
```

### Start Supabase (Docker containers)

```bash
npx supabase start
```

This starts:

- 🐘 PostgreSQL database
- 🔐 Auth service
- 📡 API endpoints
- 🎨 Supabase Studio (UI)

### Run Database Migrations

```bash
npx supabase db reset
```

This runs all migration files and sets up your database schema.

## 🔑 Step 4: Configure Environment Variables

Copy the sample environment file and fill in your values:

```bash
cp .env.sample .env
```

Then edit `.env` with your specific configuration values.

> 💡 **Tip:** Get your Supabase credentials by running `npx supabase status` after starting Supabase locally.

> ⚠️ **Note:** Supabase has updated their naming. The old variable `service_role key` is now simply called `Secret Key`.  
> 📸 [Reference screenshot](https://ik.imagekit.io/5wegcvcxp/HarishNeel/supabase-credentials.png)

## 🎯 Step 5: Start All Services

You need to run **3 services** in separate terminal windows:

### Terminal 1: Start Redis 🟥

```bash
sh start_redis.sh
```

### Terminal 2: Start API Server 🟦

```bash
sh start_server.sh
```

The server will run on `http://localhost:8000`

### Terminal 3: Start Celery Worker 🟩

```bash
sh start_worker.sh
```

This processes background tasks (document ingestion, embeddings, etc.)

## 🛑 Stop All Services

To stop everything at once:

```bash
sh stopAll.sh
```

This stops:

- 🛑 Celery Worker
- 🛑 Redis Server
- 🛑 API Server
