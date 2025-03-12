# Use the latest Ubuntu image from Docker Hub
FROM ubuntu:latest

# Avoid interactive dialogue prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and upgrade installed packages
RUN apt-get update && apt-get upgrade -y

# Install essential packages for general use:
# - sudo: for privilege escalation
# - curl, wget: for downloading files
# - git: version control system
# - vim: text editor
# - build-essential: compilers and libraries for building software
# - ca-certificates: to manage SSL certificates
# - locales: for localization support
# - software-properties-common: for managing additional repositories
RUN apt-get install -y \
    sudo \
    curl \
    wget \
    git \
    vim \
    build-essential \
    ca-certificates \
    locales \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Set up locale (adjust if needed)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# (Optional) Create a non-root user for development
RUN useradd -ms /bin/bash devuser \
    && echo "devuser:password" | chpasswd \
    && adduser devuser sudo

# Switch to the non-root user (if created)
USER devuser

# Set the working directory to the new user’s home
WORKDIR /home/devuser

# Default command to run when starting the container
CMD [ "bash" ]
