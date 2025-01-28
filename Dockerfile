# Use the latest Ubuntu base image
FROM ubuntu:latest

# Set a non-root user for safety
RUN useradd -ms /bin/bash terminaluser

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
    iputils-ping \
    && apt-get clean

# Add the new user to the sudoers file for privileged commands
RUN echo "terminaluser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set the default user to 'terminaluser'
USER terminaluser

# Set the default shell to bash
WORKDIR /home/terminaluser
SHELL ["/bin/bash", "-c"]

# Install Gotty (for the web-based terminal)
RUN curl -L https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz | tar -xz && \
    mv gotty /usr/local/bin/

# Expose the default Gotty port
EXPOSE 8080

# Run Gotty with --permit-write for an interactive terminal
CMD ["/usr/local/bin/gotty", "--permit-write", "--title-format", "Interactive Terminal", "--port", "8080", "bash"]
