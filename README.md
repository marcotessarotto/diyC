# diyC for host with Linux Kernel 4.4.74, guest Ubuntu 18.04 with python3.8 and pip3

A simple educational Linux container runtime.

It is intentionally simple and leaves a lot of stuff out. It is a
single C file of roughly 500 lines including comments showing the core
features of the Linux used to build containers. It includes also the
creation of a container from an image to clarify how images and
containers are related.


## Modified to run on a vm with Linux Kernel 4.4.74

this fork is used on a virtual machine which has a 4.4.74 Linux Kernel configured without CLONE_NEWPID and CLONE_NEWUTS.

Also included in this repo is Dockerfile for exporting an ubuntu 18.04 file system with support for python3.8 and pip3
 

## Download minimal Ubuntu 18.04 image:
docker build .

// lookup docker image just created:

docker image ls 


// run container from image:

docker run -it <image_id>


// lookup docker id of container just created -> container_id

docker ps -a 


docker export container_id > ubuntu1804.tar

gzip ubuntu1804.tar


## Download additional deb packages for Python 3.8
https://stackoverflow.com/a/45489718/974287

from another ubuntu 18.04 virtual machine:

export PACKAGES="python3.8 python3.8-minimal libpython3.8-minimal libpython3.8-stdlib"

apt-get download $(apt-cache depends --recurse --no-recommends --no-suggests \
  --no-conflicts --no-breaks --no-replaces --no-enhances \
  --no-pre-depends ${PACKAGES} | grep "^\w" | grep -v -e "libpcre3" -e "libssl1.1" -e "i386")

## installation and first run
make setup

make

mkdir images/ubuntu

tar -xf ubuntu1804.tar -C images/ubuntu/


./diyc my1 ubuntu /bin/bash



## Documentation

[http://wvi.cz/diyC/](http://wvi.cz/diyC/) or pure markdown
[in the docs directory](https://github.com/w-vi/diyC/blob/master/docs/index.md).


## Prerequisites

This is a educational piece of software and has not been tested on
many systems, here are the prerequisites:

- recent Linux kernel supporting needed namespaces and cgroups
- overlayfs
- ip tool (iproute2 package)
- iptables
- gcc
- make
- bash

Apart from overlayfs most of the distros are prepared and ready, if not
please consult your distro package manager. Overlayfs is in the
mainline kernel so it should be straightforward.

*Note*: Kernel needs to be configured to support following namespaces
PID, mount, network and UTS, cgroups are needed as well. Most of the GNU/Linux distros have
this support enabled by default.


## Installation

1. `make setup`

It creates the necessary directory structure as well as prepares the
networking part like iptables rules, bridge (diyc0) and so on. To
remove the networking bits like bridge and iptables rules run `make
net-clean` which removes them all.

2. `make`

Builds the runtime.

3. Done

It also builds a `nsexec` which executes a local command in namespaces. See `nsexec --help` to see what namespaces are available. Usage is very simple `sudo ./nsexec -pnu myhost bash` will start a new bash in new pid, network and UTS namespace.


