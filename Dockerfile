FROM ubuntu:18.04

USER root
WORKDIR /root

COPY ENTRYPOINT.sh /
COPY mininet /root/mininet
COPY ryu /root/ryu

RUN apt update && apt install -y --no-install-recommends \
    software-properties-common \
    curl \
    iproute2 \
    iputils-ping \
    mininet \
    net-tools \
    openvswitch-switch \
    openvswitch-testcontroller \
    tcpdump \
    vim \
    x11-xserver-utils \
    xterm \
    git \
    python3-pip \
    python3-setuptools \
    python3-wheel \
 && add-apt-repository -y ppa:wireshark-dev/stable \
 && echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections \
 && apt install -y tshark \
 && rm -rf /var/lib/apt/lists/* \
 && chmod +x /ENTRYPOINT.sh \
 && pip3 install networkx \
 && cd /root/ryu && pip3 install -r ./tools/pip-requires \
 && cd /root/ryu && python3 ./setup.py install

EXPOSE 6633 6653 6640

ENTRYPOINT ["/ENTRYPOINT.sh"]
