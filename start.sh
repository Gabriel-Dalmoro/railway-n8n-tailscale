#!/bin/sh

# Ensure /home/node/.n8n exists and is owned by the node user (UID 1000)
mkdir -p /home/node/.n8n
chown -R node:node /home/node/.n8n

# Start Tailscale daemon in userspace mode as root
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &

# Connect to Tailscale
tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=railway-n8n &

# Execute n8n as the unprivileged 'node' user
exec su -s /bin/sh node -c "n8n start"
