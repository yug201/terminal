FROM ubuntu:22.04

# Install basic tools
RUN apt-get update && apt-get install -y bash curl wget nano vim && apt-get clean

# Expose a dummy port (Render requires a port to keep the service alive)
EXPOSE 8080

# Start Bash
CMD ["bash"]
