#!/bin/sh

# 1. Ensure n8n directory permissions
mkdir -p /home/node/.n8n
chown -R node:node /home/node/.n8n

# 2. Ensure Tailscale runtime directories exist
mkdir -p /var/run/tailscale /var/lib/tailscale

# 3. Start Tailscale daemon in userspace mode
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &

# Give tailscaled 2 seconds to initialize its socket
sleep 2

# 4. Authenticate with Tailscale
tailscale up --authkey="${TAILSCALE_AUTHKEY}" --hostname=railway-n8n &

# 5. Start n8n engine as node user
exec su -s /bin/sh node -c "n8n start"
