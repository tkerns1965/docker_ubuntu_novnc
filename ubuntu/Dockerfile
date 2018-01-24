ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    HOME=/docker

EXPOSE $VNC_PORT \
       $NO_VNC_PORT

RUN apt update && \
    apt clean && \
    apt install -y \
        fluxbox \
        net-tools \
        python \
        wget \
        wmctrl \
        x11vnc \
        xvfb && \
    mkdir -p $HOME/noVNC/utils/websockify && \
    wget -qO- https://github.com/novnc/noVNC/archive/v0.6.2.tar.gz | \
        tar xz --strip 1 -C $HOME/noVNC && \
    wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | \
        tar xz --strip 1 -C $HOME/noVNC/utils/websockify && \
    chmod +x -v $HOME/noVNC/utils/*.sh && \
    ln -s $HOME/noVNC/vnc_auto.html $HOME/noVNC/index.html

COPY fluxbox/* $HOME/.fluxbox/
COPY bootstrap.sh .

RUN chmod u+x bootstrap.sh

CMD ["bootstrap.sh"]
