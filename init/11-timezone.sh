#!/bin/sh

test -n "$TIMEZONE" -a -f "/usr/share/zoneinfo/$TIMEZONE" && ln -nsf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime && echo "$TIMEZONE" > /etc/timezone
