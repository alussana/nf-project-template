# Use the latest Debian base image
FROM debian:bookworm-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# Update package list and install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    libhdf5-dev \
    libfreetype6-dev \
    libpng-dev \
    pkg-config \
    git \
    curl \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Create a symbolic link for python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Upgrade pip to the latest version
RUN python3 -m pip install --upgrade pip

# Install python packages
RUN python3 -m pip install \
    numpy \
    pandas \
    scipy \
    matplotlib \
    seaborn \
    scikit-learn \
    h5py \
    tables \
    scanpy \
    triesus \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 \
    lightning \
    pyarrow 