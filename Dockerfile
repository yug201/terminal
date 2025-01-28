FROM ubuntu:22.04

# Install necessary tools
RUN apt-get update && apt-get install -y bash curl wget nano vim && apt-get clean

# Install Gotty for web-based terminal access
RUN wget -O gotty.tar.gz https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xvf gotty.tar.gz && \
    mv gotty /usr/local/bin/

# Expose port 8080
EXPOSE 8080

# Start Gotty (replace "bash" with the desired shell)
CMD ["gotty", "--permit-write", "--port", "8080", "bash"]
