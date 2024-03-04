FROM python:3.10
WORKDIR /app
COPY . .

RUN pip install torch torchvision torchaudio
RUN apt-get update && apt-get install -y ffmpeg
RUN pip install -r requirements.txt

CMD ["python", "app.py"]
