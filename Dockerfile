# Use Ubuntu 24.04 base as your script expects
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    docker.io \
    cron \
    screen \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Add nexus node manager script
COPY nexus-node-manager.sh /usr/local/bin/nexus-node-manager.sh
RUN chmod +x /usr/local/bin/nexus-node-manager.sh

# Add entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Setup log directory
RUN mkdir -p /root/nexus_logs

# Expose any ports if needed (adjust if Nexus nodes expose ports)
# EXPOSE 8080

# Entrypoint runs the manager script interactively
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
