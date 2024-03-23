# Use python:3.9-slim-buster as the base image
FROM python:3.9-slim-buster

# Set maintainer label
LABEL maintainer="iskoldt"

# Install build-essential package
RUN apt-get update \
    && apt-get install -y build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy requirements files
COPY requirements.txt /app/requirements.txt
COPY requirements_advanced.txt /app/requirements_advanced.txt

# Install required Python packages specified in requirements files
# Note: "--no-cache-dir" is used to keep the image size down
RUN pip install --no-cache-dir -r requirements.txt
# Uncomment the following line if you decide to include the advanced requirements
# RUN pip install --no-cache-dir -r requirements_advanced.txt

# Copy all other files from the current directory to the /app directory in the image
COPY . /app

# Set environment variable to indicate that the application is running in a container
ENV dockerrun=yes

CMD ["python3", "-u", "ChuanhuChatbot.py","2>&1", "|", "tee", "/var/log/application.log"]
