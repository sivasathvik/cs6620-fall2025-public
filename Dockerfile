# Use an official Python base image (slim keeps the image small)
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies needed by pydub (ffmpeg)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (better Docker layer caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose the application port
EXPOSE 5000

# Run the Flask application
CMD ["python", "app.py"]