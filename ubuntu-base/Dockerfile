# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Install necessary tools
RUN apt-get -y update && \
    apt-get install -y netcat iputils-ping curl wget git tar gzip zip && \
    apt-get install -y mysql-client postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a user "ubuntu" with uid 1000, add to groups "root" and "sudo"
RUN useradd -u 1000 -m -G root,sudo ubuntu

# Copy authorized_keys file and set correct permissions
COPY authorized_keys /home/ubuntu/.ssh/authorized_keys
RUN chown ubuntu:ubuntu /home/ubuntu/.ssh/authorized_keys && \
    chmod 600 /home/ubuntu/.ssh/authorized_keys

# Install and configure SSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    echo 'PermitRootLogin no' >> /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH server as a daemon
CMD ["sudo", "/usr/sbin/sshd", "-D"]



