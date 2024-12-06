#!/bin/bash
# Instal GLIBC versi terbaru
GLIBC_VERSION="2.38"

# Unduh dan instal GLIBC
apt-get update && apt-get install -y build-essential manpages-dev wget
wget http://ftp.gnu.org/gnu/libc/glibc-$GLIBC_VERSION.tar.gz
tar -xvf glibc-$GLIBC_VERSION.tar.gz
cd glibc-$GLIBC_VERSION
mkdir build
cd build
../configure --prefix=/opt/glibc-$GLIBC_VERSION
make -j$(nproc)
make install

# Tambahkan GLIBC baru ke library path
export LD_LIBRARY_PATH=/opt/glibc-$GLIBC_VERSION/lib:$LD_LIBRARY_PATH
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
pip install --no-cache-dir -r requirements.txt
