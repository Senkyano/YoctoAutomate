FROM debian:12

USER root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Install different package needed
RUN apt-get update && apt-get install -y \
	gawk wget git diffstat unzip texinfo gcc build-essential locales \
	chrpath socat cpio python3 python3-pip python3-pexpect \
	xz-utils debianutils iputils-ping python3-git python3-jinja2 \
	libegl1-mesa libsdl1.2-dev pylint xterm bzip2 locales vim \
	file liblz4-tool zstd lz4 openssh-server \
	&& rm -fr /var/lib/apt/lists/* \
	&& mkdir /var/run/sshd

RUN pip3 install --break-system-packages kas

RUN echo 'pokyuser:yocto' | chpasswd

RUN sed -i 's/#X11Forwarding no /X11Forwarding yes/' /etc/ssh//sshd_config \
	&& sed -i 's/#11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config

RUN sed -i '-e s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US:en

RUN useradd -ms /bin/bash pokyuser && \
	echo "pokyuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 22

USER pokyuser

WORKDIR /home/userspace/project_yocto

ENTRYPOINT [ "entrypoint.sh" ]
CMD ["/bin/bash"]