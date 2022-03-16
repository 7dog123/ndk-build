FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install bison build-essential curl dos2unix flex \
    git make pbzip2 python2 python3-pip texinfo zip patch

RUN ln -s /usr/bin/python2 /usr/bin/python
RUN ln -s /usr/bin/python2-config /usr/bin/python-config

RUN pip install setuptools

RUN git clone https://android.googlesource.com/toolchain/gdb toolchain/gdb -b ndk-release-r17
RUN git clone https://android.googlesource.com/platform/ndk -b ndk-release-r17
RUN git clone --depth=50 https://android.googlesource.com/platform/prebuilts/ndk prebuilts/ndk -b ndk-release-r17
RUN git clone --depth=50 https://android.googlesource.com/platform/development -b ndk-release-r17
RUN git clone --depth=50 https://android.googlesource.com/platform/external/llvm external/llvm -b ndk-release-r17

COPY ./glob.c.patch /ndk
WORKDIR ndk

RUN pip install -r requirements.txt

RUN cd  /ndk/sources/host-tools/make-3.81 && \
    cat ../../../glob.c.patch | patch -p1

RUN cd /ndk && python checkbuild.py --no-build-tests --no-package

RUN ls
