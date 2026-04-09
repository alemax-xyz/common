#!/bin/sh

cat $(find /usr/share/ca-certificates -type f) > /etc/ssl/certs/ca-certificates.crt
