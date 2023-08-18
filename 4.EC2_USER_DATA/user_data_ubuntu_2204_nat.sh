#!/bin/bash

sed -i "s/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
sysctl -p
sysctl --system

tee /etc/systemd/system/iptable-for-nat.service > /dev/null <<-EOF
[Unit]
Description=Set iptables for NAT
After=network.target

[Service]
Type=oneshot
ExecStart=/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start iptable-for-nat.service
systemctl enable iptable-for-nat.service