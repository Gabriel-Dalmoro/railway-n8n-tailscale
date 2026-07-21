#!/bin/sh

# Start Tailscale daemon in userspace mode (for unprivileged containers)
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &

# Connect to Tailscale using Railway Environment Variable
tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=railway-n8n &

# Start n8n engine (preserves default behavior)
exec n8n start
