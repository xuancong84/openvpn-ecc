# openvpn-ecc
Openvpn server installation script using elliptic curve cryptography
[Derived from https://github.com/Nyr/openvpn-install]

By default, it uses elliptic curve sect571k1, you can change that by modifying EasyRSA-v3.0.6/vars and rebuilt the archive easyrsa.tgz

For most office uses, you do not want to route other traffics via VPN server, such as surfing the web. Thus, a new option (Option 0) is added to avoid redirecting gateway.

Moreover,
- you can make the server push gateway redirection request but temporarily disable its use in client's config file by putting -ve option numbers. In that way, you can enable that in client config at any time by commenting out those pull-filter options
- by default, client-to-client communication is enabled by default, you can disable it by modifying server.conf
- you can enable server status log by uncommenting "management localhost" in server.conf and specifying a port number

