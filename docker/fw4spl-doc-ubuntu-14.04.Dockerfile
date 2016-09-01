FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y

# Install build dependencies
RUN apt-get install -y build-essential \
                       ninja-build \
                       python2.7 \
                       git \
                       wget \
                       curl \
                       graphviz \
                       gnuplot

# Install cmake
RUN curl -sSL https://cmake.org/files/v3.6/cmake-3.6.1-Linux-x86_64.tar.gz | tar -xzC /opt
ENV PATH /opt/cmake-3.6.1-Linux-x86_64/bin/:$PATH

# Install doxygen
RUN curl -sSL http://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.11.linux.bin.tar.gz | tar -xzC /opt
ENV PATH /opt/doxygen-1.8.11/bin/:$PATH