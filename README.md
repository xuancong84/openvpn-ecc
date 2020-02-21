# openvpn-ecc
Openvpn server installation script using elliptic curve cryptography
[Derived from https://github.com/Nyr/openvpn-install]

By default, it uses elliptic curve sect571k1, you can change that by modifying EasyRSA-v3.0.6/vars and rebuilt the archive easyrsa.tgz

In most office uses, you do not want to route other traffics via VPN server, such as surfing the web. Thus, a new option is added to avoid redirecting gateway.

Moreover,
- you can make the server to push gateway redirection but temporarily disable the use in client's config file by putting -ve option numbers. Of course, you can 
- by default, client-to-client communication is enabled by default, you can disable it by modifying server.conf

