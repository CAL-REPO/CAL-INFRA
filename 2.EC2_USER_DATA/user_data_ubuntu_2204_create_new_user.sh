#!/bin/bash

# Replace these values with your desired username and password
NEW_USER_NAME=$NEW_USER_NAME
NEW_USER_PW=$NEW_USER_PW

# Create the new user
useradd -m -s /bin/bash "$NEW_USER_NAME"
# Set the user's password
echo "$NEW_USER_NAME:$NEW_USER_PW" | sudo chpasswd
# Add the user to the sudo group
usermod -aG "sudo" "$NEW_USER_NAME"

# Make ssh directory
NEW_USER_SSH_DIR="/home/$NEW_USER_NAME/.ssh"
mkdir -p "$NEW_USER_SSH_DIR"
# Change ssh configuration directory owner and group as new user
chmod 0700 "$NEW_USER_SSH_DIR"
chown -R "$NEW_USER_NAME:$NEW_USER_NAME" "$NEW_USER_SSH_DIR"

# Set SSH public key
NEW_USER_AUTH_KEY_FILE="$NEW_USER_SSH_DIR/authorized_keys"
# Copy SSH public key from root user ssh configuration directory to new user ssh configuration directory
cp "/root/.ssh/authorized_keys" "$NEW_USER_AUTH_KEY_FILE"
# Change ssh configuration directory owner and group as new user
chmod 0600 "$NEW_USER_AUTH_KEY_FILE"
chown -R "$NEW_USER_NAME:$NEW_USER_NAME" "$NEW_USER_AUTH_KEY_FILE"
sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo '\''Please login as the user \\"ubuntu\\" rather than the user \\"root\\".'\'';echo;sleep 10;exit 142" //' "$NEW_USER_AUTH_KEY_FILE"

Set new user permisstion to execute sudo with no password
NEW_USER_SUDEORS_FILE="/etc/sudoers.d/sudoers-$NEW_USER_NAME"
echo "$NEW_USER_NAME ALL=(ALL) NOPASSWD: ALL" | sudo tee "$NEW_USER_SUDEORS_FILE" > /dev/null
chmod 0440 "$NEW_USER_SUDEORS_FILE"

systemctl restart ssh