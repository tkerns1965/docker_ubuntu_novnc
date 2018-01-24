#!/bin/bash

main() {
    log_i "Starting xvfb virtual display..."
    launch_xvfb
    log_i "Starting fluxbox window manager..."
    launch_fluxbox
    log_i "Starting VNC server..."
    run_vnc_server
}

launch_xvfb() {
    # local xvfbLockFilePath="/tmp/.X1-lock"
    # if [ -f "${xvfbLockFilePath}" ]
    # then
    #     log_i "Removing xvfb lock file '${xvfbLockFilePath}'..."
    #     if ! rm -v "${xvfbLockFilePath}"
    #     then
    #         log_e "Failed to remove xvfb lock file"
    #         exit 1
    #     fi
    # fi

    # Start and wait for either Xvfb to be fully up or we hit the timeout.
    Xvfb $DISPLAY -screen 0 1366x768x24 &
    local loopCount=0
    until xdpyinfo -display $DISPLAY > /dev/null 2>&1
    do
        loopCount=$((loopCount+1))
        sleep 1
        if [ ${loopCount} -gt 5 ]; then
            log_e "xvfb failed to start"
            exit 1
        else
            log_i "waiting for xvfb to start..."
        fi
    done
}

launch_fluxbox() {
    # Start and wait for either fluxbox to be fully up or we hit the timeout.
    startfluxbox &
    local loopCount=0
    until wmctrl -m > /dev/null 2>&1
    do
        loopCount=$((loopCount+1))
        sleep 1
        if [ ${loopCount} -gt 5 ]; then
            log_e "fluxbox failed to start"
            exit 1
        else
            log_i "waiting for fluxbox to start..."
        fi
    done
}

run_vnc_server() {
    mkdir -p "$HOME/.vnc"
    x11vnc -storepasswd "$VNC_PASSWORD" "$HOME/.vnc/passwd"
    x11vnc -display $DISPLAY -rfbport 5901 -usepw &
    $HOME/noVNC/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &
    wait $!
}

log_i() {
    log "[INFO] ${@}"
}

log_w() {
    log "[WARN] ${@}"
}

log_e() {
    log "[ERROR] ${@}"
}

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ${@}"
}

control_c() {
    echo ""
    exit
}

trap control_c SIGINT SIGTERM SIGHUP

main

exit
