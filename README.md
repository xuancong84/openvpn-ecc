# openvpn-ecc
Openvpn server installation script (derived from https://github.com/Nyr/openvpn-install) using elliptic curve cryptography


By default, it uses elliptic curve ED25519, you can change that by modifying EASYRSA\_ALGO and EASYRSA\_CURVE in openvpn-install.sh and re-run it.

For most office uses, you do not want to route other traffics via VPN server, such as surfing the web. Thus, a new option (Option 0) is added to avoid redirecting gateway.

Moreover,
- you can make the server push gateway redirection request but temporarily disable its use in client's config file by putting -ve option numbers. In that way, you can enable that in client config at any time by commenting out those pull-filter options
- by default, client-to-client communication is enabled by default, you can disable it by modifying server.conf
- you can enable server status log by uncommenting "management localhost" in server.conf and specifying a port number


# Server Installation
Git clone the repository, and run openvpn-install.sh inside the directory.
If you need the server to support redirect gateway, you need to do 2 extra things:
1. Set `net.ipv4.ip_forward=1` in `/etc/sysctl.conf`, and reload it (i.e., `sysctl --system`)
2. Allow forwarding in IP table rules, i.e., `iptables -P FORWARD ACCEPT` (usually present by default), and optionally for better security: `iptables -A FORWARD -s <your-VPN-intranet, e.g., 10.8.0.0>/24 -j ACCEPT` and `iptables -A FORWARD -j DROP`
3. Add iptables NAT rule, `iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to-source <192.168.1.6:VPN-server-LAN-IP>` (change 10.8.0.0 to your VPN Intranet address)
4. Allow replies from established connections (and related control messages) to be forwarded, `iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT`
5. `apt install iptables-persistent` and `iptables-save >/etc/iptables/rules.v4` (and/or v6) to save iptables across reboot.

# Client Installation
For command-line installation, after "apt-get install openvpn", run "openvpn --config client.ovpn"

For GUI installation, install OpenVPN GUI and import profile client.ovpn

# References:
- Safety of various elliptic curves, http://safecurves.cr.yp.to/
- Use elliptic curve cryptography or OpenVPN, https://blog.mirabellette.eu/index.php?article35/a-highly-secure-openvpn-2-4-configuration-2018
