FROM ubuntu:20.04

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/time

WORKDIR /opt

RUN apt update && apt install -y \
        build-essential \
        gcc-10 \
        g++-10 \
        cpp-10 \
        git \
        libssl-dev \
        libpcre2-dev \
        bison \
        flex \
        libpcre3-dev \
        libev-dev \
        libavl-dev \
        libprotobuf-c-dev \
        protobuf-c-compiler \
        swig \
        lua5.2 \
        pkg-config \
        libpcre++-dev \
        openssl \
        libcrypto++-dev \
        doctest-dev

# Set C++20
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10

# Install CMake
RUN git clone https://github.com/Kitware/CMake.git cmake_repo && \
    cd cmake_repo && \
    git checkout v3.19.8 && \
    ./bootstrap && \
    make && \
    make install && \
    cd .. && \
    rm cmake_repo -r

# Install LibYANG
RUN git clone https://github.com/CESNET/libyang.git && \
    cd libyang && \
    git checkout devel && \
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

# Instal Sysrepo
RUN git clone https://github.com/sysrepo/sysrepo.git && \
    cd sysrepo && \
    git checkout devel && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm sysrepo -r

RUN git clone https://github.com/sysrepo/sysrepo-cpp.git && \
    cd sysrepo-cpp && \
    mkdir build && \
    cd build && \
    cmake -DBUILD_TESTING=FALSE .. && \
    make && \
    make install && \
    cd ../.. && \
    rm sysrepo-cpp -r

WORKDIR /

COPY files/start.sh start.sh
COPY model/raspberry_pi.yang /opt/raspberry_pi.yang

RUN chmod +x start.sh

ENV LD_LIBRARY_PATH /usr/local/lib

CMD [ "./start.sh" ]
