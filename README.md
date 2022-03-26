# docker-mininet-sdnlab

The Docker image for [Mininet](http://mininet.org/).

Forked from [iwaseyusuke/docker-mininet](https://github.com/iwaseyusuke/docker-mininet). This image added some source directories and built ryu tools for the lab.

## Docker Pull Command

Download from [Docker Hub](https://hub.docker.com/)

```bash
docker pull junyangzhang/mininet-sdnlab
```

## Docker Run Command

```bash
#!/bin/bash
docker run -it --rm --privileged \
    -e DISPLAY="${DISPLAY//localhost/host.docker.internal}" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /lib/modules:/lib/modules \
    --mount type=bind,source="$HOME/.Xauthority",target=/root/.Xauthority \
    -p 51419:8080 \
    --add-host host.docker.internal:host-gateway \
    junyangzhang/mininet-sdnlab
```

## How to clone and build the docker image

```bash
git clone https://github.com/junyang-zh/docker-mininet-sdnlab
cd docker-mininet-sdnlab
git submodule update --init --recursive
sudo docker build -t junyangzhang/mininet-sdnlab:latest .
```

## TIPS

### Open X Window applications in containers

If you could not open `xterm` or other X Window applications, or faced to the
following error message;

```bash
root@26f36691a400:~# xterm
No protocol specified
Warning: This program is an suid-root program or is being run by the root user.
The full text of the error or warning message cannot be safely formatted
in this environment. You may get a more descriptive message by running the
program as a non-root user or by removing the suid bit on the executable.
xterm: Xt error: Can't open display: %s
```

Please add `root` user to the local access control list of xhost on your
"Docker host" (not on your containers).

```bash
$ xhost +si:localuser:root
localuser:root being added to access control list
```
