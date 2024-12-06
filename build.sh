#!/bin/bash

# Instal wget untuk mengunduh file
apt-get update && apt-get install -y wget

# Instal GLIBC versi terbaru
GLIBC_VERSION="2.38"

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

# Instal library tambahan yang diperlukan
apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6

# Instal dependensi Python
pip install -r requirements.txt
