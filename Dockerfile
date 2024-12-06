# Gunakan base image Python 3.12
FROM python:3.12-slim

# Perbarui sistem dan instal library sistem yang diperlukan
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    gawk \
    bison \
    && rm -rf /var/lib/apt/lists/*

# Instal GLIBC versi stabil
ENV GLIBC_VERSION=2.38
RUN wget http://ftp.gnu.org/gnu/libc/glibc-$GLIBC_VERSION.tar.gz && \
    tar -xvf glibc-$GLIBC_VERSION.tar.gz && \
    cd glibc-$GLIBC_VERSION && \
    mkdir build && cd build && \
    ../configure --prefix=/opt/glibc-$GLIBC_VERSION && \
    make -j$(nproc) && make install && \
    rm -rf /glibc-$GLIBC_VERSION*

# Tambahkan GLIBC baru ke library path
ENV LD_LIBRARY_PATH=/opt/glibc-$GLIBC_VERSION/lib:$LD_LIBRARY_PATH

# Tentukan direktori kerja di dalam container
WORKDIR /app

# Salin file requirements.txt
COPY requirements.txt /app/

# Perbarui pip dan instal dependensi
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r /app/requirements.txt --verbose

# Salin semua file dari host ke container
COPY . .

# Ekspos port yang digunakan aplikasi
EXPOSE 8000

# Jalankan aplikasi menggunakan Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
