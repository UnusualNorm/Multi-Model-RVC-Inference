FROM python:3.10-slim
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends build-essential libx11-dev ffmpeg && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir torch torchvision torchaudio
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
ENTRYPOINT ["python", "app.py"]
