#!/bin/bash
# Run the Nexus Node Manager script inside the container

# Make sure docker daemon is running
if ! pgrep dockerd >/dev/null 2>&1; then
    dockerd --host=unix:///var/run/docker.sock &
    # Wait for docker daemon to start
    until docker info >/dev/null 2>&1; do
        sleep 1
    done
fi

# Run your manager script
exec /usr/local/bin/nexus-node-manager.sh
