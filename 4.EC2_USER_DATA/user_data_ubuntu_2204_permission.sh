#!/bin/bash
#ami-0c9c942bd7bf113a2

echo "username:userpw" | chpasswd
sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ubuntu\\" rather than the user \\"root\\".'\'';echo;sleep 10;exit 142" //' /root/.ssh/authorized_keys
systemctl restart ssh