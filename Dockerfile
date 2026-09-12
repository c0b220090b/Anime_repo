# 1. ベースイメージを CUDA 13.0 に変更
FROM nvidia/cuda:13.0.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# --- OSパッケージ ---
# build-essential, python3-dev : sqlite3 等のネイティブモジュールのビルドに必要
# curl                          : Node.jsセットアップスクリプト取得に必要
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-dev \
    git \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libglfw3 \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# --- Node.js 20.x (AI Toolkit UI用) ---
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
RUN pip3 install --no-cache-dir --upgrade pip

# --- Python パッケージ ---
# uv : ComfyUI-Managerがpip操作に使用
RUN pip3 install --no-cache-dir uv

# 6. インストール先を cu130 に変更
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# comfy_kitchenをrequirements.txtの指定より新しいバージョンに固定
# (古いバージョンだと comfy.ldm.modules.attention の import でエラーになるため)
RUN pip3 install --no-cache-dir --upgrade comfy_kitchen --break-system-packages
