[ -z "$TIMEZONE" -a -n "$TZ" ] && TIMEZONE="$TZ"
[ -z "$TZ" -a -n "$TIMEZONE" ] && TZ="$TIMEZONE"
[ -z "$TZ" ] && TZ=UTC TIMEZONE=UTC
[ "$TIMEZONE" != "$TZ" ] && echo "Invalid TIMEZONE/TZ" 1>&2 && exit 13
[ ! -f "/usr/share/zoneinfo/$TZ" ] && echo "Invalid TIMEZONE/TZ" && exit 14
suexec ln -nsf "/usr/share/zoneinfo/$TZ" /etc/localtime && su -p -s /bin/sh -c 'echo "$TZ" > /etc/timezone'

export TZ TIMEZONE

su -p -s /bin/sh -c 'cat > /etc/environment.d/11-timezone.conf' <<-EOF
	TZ=$TZ
	TIMEZONE=$TZ
EOF
