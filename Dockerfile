FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install bison build-essential curl dos2unix flex \
    git make pbzip2 python2 python3-pip texinfo zip patch

RUN ln -s /usr/bin/python2 /usr/bin/python
RUN ln -s /usr/bin/python2-config /usr/bin/python-config

RUN pip install setuptools

RUN git clone https://github.com/7dog123/ndk-build && \
    cd ndkbuild && \
    git submodule update --init

COPY ./glob.c.patch ndk-build/platform/ndk
WORKDIR ndk-build/platform/ndk

RUN pip install -r requirements.txt

RUN cd  /ndk-build/platform/ndk/sources/host-tools/make-3.81 && \
    cat ../../../../../glob.c.patch | patch -p1

RUN cd /ndk-build/platform/ndk && python checkbuild.py --no-build-tests --no-package

RUN ls
