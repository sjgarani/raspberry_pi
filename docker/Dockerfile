FROM ubuntu:18.04

WORKDIR /opt

RUN apt update && apt install -y \
        build-essential \
        git \
        # libssl-dev \
        # libpcre2-dev \
        bison \
        flex \
        libpcre3-dev \
        libev-dev \
        libavl-dev \
        libprotobuf-c-dev \
        protobuf-c-compiler \
        swig \
        #python-dev \
        lua5.2 \
        pkg-config \
        libpcre++-dev \
        openssl \
        libssl1.0-dev \
        libcrypto++-dev

# Install CMake
RUN git clone https://github.com/Kitware/CMake.git cmake_repo && \
    cd cmake_repo && \
    git checkout v3.19.8 && \
    ./bootstrap && \
    make && \
    make install && \
    cd .. && \
    rm cmake_repo -r

# Install base
RUN git clone https://github.com/CESNET/libyang.git && \
    cd libyang && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm libyang -r

RUN git clone https://github.com/CESNET/libyang-cpp.git && \
    cd libyang-cpp && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm libyang-cpp -r
