FROM python:3.13-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    poppler-utils \
    tesseract-ocr \
    libmagic-dev \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry + export plugin
RUN pip install --no-cache-dir poetry
RUN pip install --no-cache-dir poetry-plugin-export

COPY pyproject.toml poetry.lock* ./

# 🔥 Export deps
RUN poetry export -f requirements.txt --without-hashes -o requirements.txt

# Remove torch (prevents CUDA install)
RUN grep -v torch requirements.txt > req.txt

# Install deps
RUN pip install --no-cache-dir -r req.txt

# Install CPU-only torch
RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu

COPY . .

EXPOSE 8000
CMD ["uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8000"]