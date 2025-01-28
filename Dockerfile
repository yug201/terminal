# Use the latest Ubuntu base image
FROM ubuntu:latest

# Update the system and install necessary tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    sudo \
    curl \
    wget \
    nano \
    vim \
    git \
    build-essential \
    python3 \
    python3-pip \
    zip \
    unzip \
    net-tools \
    iputils-ping && \
    apt-get clean

# Set the default user as root
USER root

# Set the working directory for root
WORKDIR /root

# Install Gotty (for the web-based terminal)
RUN curl -L https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz | tar -xz && \
    mv gotty /usr/local/bin/

# Expose Gotty port
EXPOSE 8080

# Start Gotty as root
CMD ["/usr/local/bin/gotty", "--permit-write", "--title-format", "Root Terminal", "--port", "8080", "bash"]
