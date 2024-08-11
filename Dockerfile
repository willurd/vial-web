FROM ubuntu:22.04

ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt-get install -y python3 build-essential libffi-dev git curl wget zlib1g-dev zip unzip

RUN apt-get install -y gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 20 && \
  update-alternatives --config python

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22
ENTRYPOINT service ssh start && bash
