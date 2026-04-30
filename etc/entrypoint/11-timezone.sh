[ -z "$TIMEZONE" -a -n "$TZ" ] && TIMEZONE="$TZ"
[ -z "$TZ" -a -n "$TIMEZONE" ] && TZ="$TIMEZONE"
[ -z "$TZ" ] && TZ=UTC TIMEZONE=UTC
[ "$TIMEZONE" != "$TZ" ] && echo "Invalid TIMEZONE/TZ" 1>&2 && exit 13
[ ! -f "/usr/share/zoneinfo/$TZ" ] && echo "Invalid TIMEZONE/TZ" && exit 14
ln -nsf "/usr/share/zoneinfo/$TZ" /etc/localtime && echo "$TZ" > /etc/timezone
export TZ TIMEZONE
