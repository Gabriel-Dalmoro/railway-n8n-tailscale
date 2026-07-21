FROM n8nio/n8n:latest

USER root

# Install Tailscale & iptables dependencies
RUN apk add --no-cache tailscale iptables

# Copy and set execution permissions for the startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

USER node

ENTRYPOINT ["/start.sh"]
