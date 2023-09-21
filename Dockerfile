FROM debian:bullseye

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y gawk wget git diffstat unzip texinfo gcc build-essential \
	chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
	python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit \
	mesa-common-dev zstd liblz4-tool locales curl vim sudo file

ARG USERNAME=dev

ARG PUID=1000

ARG PGID=1000

RUN groupadd -g ${PGID} ${USERNAME} \
            && useradd -u ${PUID} -g ${USERNAME} -d /home/${USERNAME} ${USERNAME} \
            && mkdir /home/${USERNAME} \
            && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

RUN echo ${USERNAME}:password | chpasswd

RUN usermod -aG sudo ${USERNAME}

RUN echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
RUN locale-gen
RUN dpkg-reconfigure --frontend noninteractive locales

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER ${USERNAME}

WORKDIR /home/${USERNAME}/workspaces/yocto
