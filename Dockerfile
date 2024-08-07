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

COPY . /root/vial-web

WORKDIR /root/vial-web

RUN git clone https://github.com/vial-kb/vial-gui.git
RUN git clone https://github.com/vial-kb/via-keymap-precompiled.git

RUN echo 'source "/root/vial-web/emsdk/emsdk_env.sh"' >> $HOME/.bash_profile

RUN sed -i 's/\r$//' ./version.sh
RUN chmod +x ./version.sh

RUN sed -i 's/\r$//' ./fetch-emsdk.sh
RUN chmod +x ./fetch-emsdk.sh
RUN ./fetch-emsdk.sh

RUN sed -i 's/\r$//' ./fetch-deps.sh
RUN chmod +x ./fetch-deps.sh
RUN ./fetch-deps.sh

RUN sed -i 's/\r$//' ./build-deps.sh
RUN chmod +x ./build-deps.sh
RUN ./build-deps.sh

WORKDIR /root/vial-web/src

RUN sed -i 's/\r$//' ./build.sh
RUN chmod +x ./build.sh
RUN ./build.sh

COPY ./http-server-cors.py /root/vial-web/src/build/http-server-cors.py

WORKDIR /root/vial-web/src/build

CMD ["/usr/bin/python", "http-server-cors.py"]
EXPOSE 8000
