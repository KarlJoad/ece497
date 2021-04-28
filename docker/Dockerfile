FROM ubuntu:20.04

RUN apt-get update && apt-get full-upgrade -y

# autoconf is only needed until the dependency script contains all correct dependencies
RUN apt-get install sudo curl git direnv autoconf -y && \
	adduser --quiet --disabled-password --shell /bin/bash --home /home/chipyard --gecos "User" chipyard && \
	echo "chipyard:<a href="mailto://chipyard">chipyard</a>" | chpasswd && \
	usermod -aG sudo chipyard

# Setup timezone information, as some chipyard deps depend on tzdata
ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install the necessary packages for the chipyard user and development
COPY ./ubuntu-chipyard-deps-setup.sh .
RUN ./ubuntu-chipyard-deps-setup.sh

RUN git clone https://git.veripool.org/git/verilator && \
	cd verilator && \
	git checkout v4.034 && \
    autoconf && ./configure && make -j$(nproc) && sudo make install

# Set up the necessary environment for the chipyard user
USER chipyard
WORKDIR /home/chipyard

RUN git clone https://github.com/ucb-bar/chipyard
ENV HOME /home/chipyard
