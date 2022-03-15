FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install bison build-essential curl dos2unix flex \
     git make pbzip2 python python-pip texinfo zip


RUN pip install setuptools

RUN git clone https://android.googlesource.com/platform/ndk -b ndk-release-r17

WORKDIR ndk

RUN python checkbuild.py --no-build-tests

RUN ls
