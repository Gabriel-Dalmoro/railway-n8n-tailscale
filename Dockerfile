# Stage 1: Pull Tailscale binaries directly from official image
FROM tailscale/tailscale:latest AS tailscale

# Stage 2: n8n base image
FROM n8nio/n8n:latest

USER root

# Copy tailscale binaries into system PATH
COPY --from=tailscale /usr/local/bin/tailscale /usr/local/bin/tailscale
COPY --from=tailscale /usr/local/bin/tailscaled /usr/local/bin/tailscaled

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

USER node

ENTRYPOINT ["/start.sh"]
