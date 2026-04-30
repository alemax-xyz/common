FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update

RUN mkdir /build /rootfs
WORKDIR /build
RUN apt-get download \
        libfcgi0t64 \
        libtinfo6 \
        libreadline8t64 \
        libncurses6 \
        libncursesw6 \
        libstdc++6 \
        media-types \
        tzdata \
        ncurses-base \
        readline-common \
        ca-certificates \
        mailcap \
        fcgiwrap
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
RUN mv -f usr/lib/mime/packages/mailcap usr/lib/mime/mailcap \
 && rm -rf \
        etc/ca-certificates \
        etc/init.d/ \
        etc/mailcap.order \
        etc/*/README \
        usr/bin \
        usr/lib/mime/packages \
        usr/lib/mime/debian-view \
        usr/sbin/update-* \
        usr/share/bug \
        usr/share/doc \
        usr/share/gcc* \
        usr/share/gdb \
        usr/share/info \
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

COPY etc/ etc/

WORKDIR /


FROM clover/base

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
