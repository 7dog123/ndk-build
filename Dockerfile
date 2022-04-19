FROM ubuntu:latest

RUN apt-get update

RUN DEBIAN_FRONTEND noninteractive \
    apt-get -y install bison build-essential curl flex \
    git make pbzip2 python python-pip texinfo \
    uuid-runtime zip unzip wget

RUN git clone https://github.com/7dog123/ndk-build && \
    cd ndk-build && \
    git submodule update --init && \
    rm -rv .git

COPY ./glob.c.patch ndk-build/platform/ndk
WORKDIR ndk-build/platform/ndk

RUN ln -s /usr/bin/python2 /usr/bin/python
RUN ln -s /usr/bin/python2-config /usr/bin/python-config

RUN pip install setuptools

RUN pip install -r requirements.txt

RUN cd  /ndk-build/platform/ndk/sources/host-tools/make-3.81 && \
   cat ../../../../../glob.c.patch | patch -p1

RUN cd /ndk-build/platform/ndk && python checkbuild.py --no-build-tests --no-package

#RUN ls /home -a
