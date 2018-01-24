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
    apt install -y \
        fluxbox \
        wmctrl \
        x11vnc \
        xvfb && \
    apt clean
RUN apt install -y \
        gedit
RUN apt install -y \
        net-tools \
        python \
        wget && \
    mkdir -p $HOME/noVNC/utils/websockify && \
    wget -qO- https://github.com/novnc/noVNC/archive/v0.6.2.tar.gz | tar xz --strip 1 -C $HOME/noVNC && \
    wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | \
        tar xz --strip 1 -C $HOME/noVNC/utils/websockify && \
    chmod +x -v $HOME/noVNC/utils/*.sh && \
    ln -s $HOME/noVNC/vnc_auto.html $HOME/noVNC/index.html
RUN mkdir -p $HOME/gnucash_source && \
    wget -qO- https://sourceforge.net/projects/gnucash/files/gnucash%20%28stable%29/2.6.19/gnucash-2.6.19.tar.gz | \
        tar xz --strip 1 -C $HOME/gnucash_source
# RUN apt install -y autoconf
# RUN apt install -y automake
# RUN apt install -y autotools-dev
RUN apt install -y build-essential
RUN apt install -y cmake
# RUN apt install -y google-mock
# RUN apt install -y gtk+3.0
# RUN apt install -y guile-2.0
RUN apt install -y guile-2.0-dev
# RUN apt install -y icu-devtools
RUN apt install -y intltool
# RUN apt install -y libboost-all-dev
RUN apt install -y libdbi-dev
RUN apt install -y libglib2.0-dev
RUN apt install -y libgnomecanvas2-dev
RUN apt install -y libgoffice-0.8-dev
# RUN apt install -y libgtest-dev
# RUN apt install -y libgtk-3-dev
# RUN apt install -y libicu-dev
# RUN apt install -y libltdl-dev
# RUN apt install -y libsigsegv2
# RUN apt install -y libtool
RUN apt install -y libwebkit-dev
# RUN apt install -y libwebkit2gtk-4.0-37
# RUN apt install -y libwebkit2gtk-4.0-dev
RUN apt install -y libxml++2.6-dev
RUN apt install -y libxslt1-dev
# RUN apt install -y m4
# RUN apt install -y pkg-config
# RUN apt install -y swig2.0
RUN apt install -y texinfo
RUN apt install -y xsltproc
RUN cd $HOME/gnucash_source && \
    mkdir build-cmake && \
    cd build-cmake && \
    cmake -D CMAKE_INSTALL_PREFIX=$HOME/gnucash_cmake -D WITH_AQBANKING=OFF -D WITH_OFX=OFF $HOME/gnucash_source && \
    make && \
    make install
COPY fluxbox/* /docker/.fluxbox/
COPY bootstrap.sh /
RUN chmod u+x /bootstrap.sh
CMD '/bootstrap.sh'
