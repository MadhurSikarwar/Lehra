# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies (ffmpeg and libsndfile for librosa/audioread)
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg libsndfile1 && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the rest of the application
COPY . /app/

# Expose port (will be overridden by $PORT on Render/Railway)
EXPOSE 3000

# Run the application with Gunicorn
CMD gunicorn --bind 0.0.0.0:${PORT:-3000} --workers 1 --threads 2 server:app
