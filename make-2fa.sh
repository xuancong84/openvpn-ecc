#!/bin/bash

if [ $# == 0 ]; then
	echo "Usage: $0 username_no_space"
	exit
fi

TMP=/tmp/$$
(echo '-1' && sleep 1) | unbuffer -p google-authenticator \
  --time-based \
  --force \
  --disallow-reuse \
  --rate-limit=3 \
  --rate-time=30 \
  --window-size=3 \
  --issuer="OpenVPN" \
  --label="$1" \
  --qr-mode=utf8 \
  --secret=$1.google_authenticator | cat >$TMP

chmod 600 $1.google_authenticator
cat $TMP >>$1.google_authenticator
rm -rf $TMP

echo "TODO 1/3: 2FA QR stored in $1.google_authenticator"
echo 'TODO 2/3: Please add the following lines into the user .ovpn:
auth-user-pass
<auth-user-pass>
dummy
dummy
</auth-user-pass>
static-challenge "Enter Google Authenticator code" 0'
echo "TODO 3/3: add the user entry into make-2fa.sh"
