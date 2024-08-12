FROM ubuntu:22.04

ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt-get install -y python3 build-essential libffi-dev git curl wget zlib1g-dev zip unzip

RUN apt-get install -y gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev

RUN apt-get install -y vim

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 20 && \
  update-alternatives --config python

# Setup SSH
RUN apt-get install -y openssh-server
RUN useradd -m -s /bin/bash vialuser
RUN echo "vialuser:vialpass" | chpasswd
RUN mkdir -p /home/vialuser/vial-web

# Start SSH server
EXPOSE 22
ENTRYPOINT ["/bin/bash", "-c" , "service ssh start && /bin/bash"]
