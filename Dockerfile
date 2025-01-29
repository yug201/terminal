# Use the latest Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=8080

# Update the system and install necessary tools
RUN apt-get update && apt-get install -y \
    sudo curl wget nano vim git build-essential \
    python3 python3-pip zip unzip net-tools iputils-ping && \
    apt-get clean

# Install Gotty (for the web-based terminal)
RUN curl -L https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz | tar -xz && \
    mv gotty /usr/local/bin/

# Expose Gotty port
EXPOSE $PORT

# Start Gotty as root (no sudo needed)
CMD ["/usr/local/bin/gotty", "--permit-write", "--title-format", \"Root Terminal\", "--port", "8080", "bash"]
