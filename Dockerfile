FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y \
        wget \
        curl \
        gnupg \
        fasttrack-archive-keyring \
        python3-software-properties \
        software-properties-common \
        apt-utils

RUN ( true \
     && echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" \
     && echo "deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free" \
     && echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" \
     && echo "deb http://deb.debian.org/debian/ bullseye-backports main contrib non-free" \
 )  > /etc/apt/sources.list.d/bullseye.list \
 && echo "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib" > /etc/apt/sources.list.d/fasttrack.list \
 && apt-get update


RUN mkdir /build /rootfs
WORKDIR /build
RUN apt-get download \
        libtinfo6 \
        libreadline8 \
        libncurses5 \
        libncursesw5 \
        libssl1.1 \
        libssl3 \
        libstdc++6 \
        libc-bin \
        tzdata \
        ncurses-base \
        readline-common \
        ca-certificates \
        mailcap
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
RUN mv -f usr/lib/mime/packages/mailcap usr/lib/mime/mailcap \
 && rm -rf \
        etc/ca-certificates \
        etc/default \
        etc/ld.so.* \
        etc/bindresvport.blacklist \
        etc/gai.conf \
        etc/init \
        etc/init.d \
        etc/mailcap.order \
        etc/*/README \
        usr/bin/cautious-launcher \
        usr/bin/compose \
        usr/bin/edit \
        usr/bin/print \
        usr/bin/run-mailcap \
        usr/bin/see \
        usr/lib/mime/packages \
        usr/lib/mime/debian-view \
        usr/bin/catchsegv \
        usr/bin/ldd \
        usr/bin/tzselect \
        usr/sbin/update-ca-certificates \
        usr/sbin/update-mime \
        usr/sbin/tzconfig \
        usr/share/bug \
        usr/share/doc \
        usr/share/gcc* \
        usr/share/gdb \
        usr/share/info \
        usr/share/libc-bin \
        usr/share/lintian \
        usr/share/man \
 && find \
        etc/mime.types \
        usr/lib/mime/mailcap \
        usr/share/readline/inputrc \
    | xargs -I % sed -i -r \
        -e 's,^[[:space:]]*[#]+.*$,,g' \
        -e 's,[[:space:]]+, ,g' \
        -e '/^[[:space:]]*$/d' \
        % \
 && ln -s /usr/lib/mime/mailcap etc/mailcap \
 && cat usr/share/ca-certificates/mozilla/*.crt > etc/ssl/certs/ca-certificates.crt

COPY init/ etc/init/

WORKDIR /


FROM clover/base

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
