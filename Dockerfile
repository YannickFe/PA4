FROM  --platform=linux/amd64 ubuntu:latest

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y unminimize
RUN yes | unminimize

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y ubuntu-standard man-db coreutils bash

RUN apt-get update && apt-get install -y qemu-system-x86
RUN apt-get install -y git gcc make

RUN git config --global user.name "Yannick Fenz'l"
RUN git config --global user.email "yannick.fenzl@icloud.com"

RUN apt-get install -y build-essential

WORKDIR /home/ubuntu/xv6-public