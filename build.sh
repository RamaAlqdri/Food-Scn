#!/bin/bash

# Perbarui repository dan install library sistem yang diperlukan
apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6

# Instal dependensi Python
pip3 install --no-cache-dir -r requirements.txt
