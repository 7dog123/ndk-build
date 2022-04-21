FROM ubuntu:latest

RUN ls

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive TZ=US/Central \
    apt-get install -y bison build-essential curl flex \
    git make pbzip2 python python3-pip texinfo \
    uuid-runtime zip unzip wget

WORKDIR /platform/ndk

RUN ln -sf /usr/bin/python2 /usr/bin/python
RUN ln -sf /usr/bin/python2-config /usr/bin/python-config

RUN pip install setuptools

RUN pip install -r requirements.txt

RUN cd  /ndk-build/platform/ndk/sources/host-tools/make-3.81 && \
   cat ../../../../../glob.c.patch | patch -p1

RUN cd /ndk-build/platform/ndk && python checkbuild.py --no-build-tests --no-package

#RUN ls /home -a
