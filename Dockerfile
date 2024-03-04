# Use the official PyTorch base image
FROM pytorch/pytorch:latest

# The readme says to install this, so just do it anyways
RUN pip install torch torchvision torchaudio

# Install ffmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Set the working directory
WORKDIR /app

# Create directories for model downloads
RUN mkdir -p /assets/hubert /assets/rvmpe

# Download and save pre-trained models
RUN curl -LJO https://huggingface.co/lj1995/VoiceConversionWebUI/raw/main/hubert_base.pt -o /assets/hubert/hubert_base.pt
RUN curl -LJO https://huggingface.co/lj1995/VoiceConversionWebUI/raw/main/rmvpe.pt -o /assets/rvmpe/rmvpe.pt

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
