# 1. ベースイメージを CUDA 13.0 に変更
FROM nvidia/cuda:13.0.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-dev \
    git \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libglfw3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
RUN pip3 install --no-cache-dir --upgrade pip

# 6. インストール先を cu130 に変更
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

