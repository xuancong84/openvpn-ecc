#!/bin/bash

declare -A AUTH_LIST
AUTH_LIST[test]=BNOUXH7P4ADSEYFZRNQWE6WRVI






SECRET="${AUTH_LIST[$common_name]}"
if [ ! "$SECRET" ]; then
	exit 0
fi

PASSWORD="$(sed -n '2p' "$1")"
B64_OTP="$(echo "$PASSWORD" | cut -d ':' -f 3)"
OTP="$(echo "$B64_OTP" | base64 -d 2>/dev/null)"
VALID_CODES="$(oathtool --totp --base32 --window=4 "$SECRET" 2>/dev/null)"

if echo "$VALID_CODES" | grep -Fxq "$OTP"; then
    echo "$(date '+%F %T') ALLOW CN='$CN': OTP success"
    exit 0
else
    echo "$(date '+%F %T') DENY CN='$CN': OTP failed"
    exit 1
fi

