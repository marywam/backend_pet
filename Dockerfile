# Use official Python base image
FROM python:3.11-slim

# Set workdir inside container
WORKDIR /app

# Install system dependencies (for psycopg2, Pillow, etc. adjust as needed)
RUN apt-get update && apt-get install -y \
    build-essential libpq-dev libjpeg-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY ecommerce/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY ecommerce/ /app/

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Collect static files (if needed)
# RUN python manage.py collectstatic --noinput

# Run migrations and start server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
