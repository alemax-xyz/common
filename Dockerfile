FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8 \
    SANDBOX_ROOT=/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y wget openssl ca-certificates

ADD https://github.com/alemax-xyz/misc-tools.git#main /usr/local/bin/

RUN mkdir -p /build /rootfs

WORKDIR /build

COPY build/ .

COPY --from=clover/base:latest /var/lib/packages/ var/lib/packages/

RUN apt-sandbox --install --verstamp \
        --apt-config \
            APT::Install-Recommends=false \
            APT::Get::Upgrade==false \
        --repository . \
        --keyring . \
        --installed var/lib/packages \
        --obsolete packages.obsolete \
        --required packages.required

WORKDIR /rootfs

RUN mv -f usr/lib/mime/packages/mailcap usr/lib/mime/mailcap \
 && rm -rf \
        etc/ca-certificates/* \
        etc/init.d/ \
        etc/mailcap.order \
        etc/*/README \
        usr/bin \
        usr/lib/mime/packages \
        usr/lib/mime/debian-view \
        usr/lib/systemd \
        usr/sbin/update-* \
        usr/share/bug \
        usr/share/doc \
        usr/share/gcc* \
        usr/share/gdb \
        usr/share/info \
        usr/share/lintian \
        usr/share/man \
 && sed -i -E \
        -e 's,^[[:space:]]*[#]+.*$,,g' \
        -e 's,[[:space:]]+, ,g' \
        -e '/^[[:space:]]*$/d' \
        etc/mime.types \
        usr/lib/mime/mailcap \
        usr/share/readline/inputrc \
        usr/share/zoneinfo/leap-seconds.list \
 && sed -i -E \
        -e 's,^[[:space:]]*[#]+.*$,,g' \
        -e '/^[[:space:]]*$/d' \
        usr/share/zoneinfo/iso3166.tab \
        usr/share/zoneinfo/leapseconds \
        usr/share/zoneinfo/tzdata.zi \
        usr/share/zoneinfo/zone.tab \
        usr/share/zoneinfo/zone1970.tab \
        usr/share/zoneinfo/zonenow.tab \
 && ln -s /usr/lib/mime/mailcap etc/mailcap

COPY rootfs/ ./

WORKDIR /

FROM clover/base

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
