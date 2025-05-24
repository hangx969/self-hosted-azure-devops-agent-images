#!/bin/bash
set -e

UBUNTU_CODENAME=$(lsb_release -cs)

# Add Azure ubuntu repositories
echo "Adding Azure ubuntu repositories..."
tee /etc/apt/sources.list <<EOF
deb http://azure.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME} main restricted universe multiverse
deb http://azure.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME}-updates main restricted universe multiverse
deb http://azure.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME}-backports main restricted universe multiverse
deb http://azure.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME}-security main restricted universe multiverse
EOF

# Add Docker repositories and key
echo "Adding Azure Docker repo key and repositories..."
curl -fsSL https://mirror.azure.cn/docker-ce/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

tee /etc/apt/sources.list.d/docker.list <<EOF
deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://mirror.azure.cn/docker-ce/linux/ubuntu ${UBUNTU_CODENAME} stable
EOF

# Add azk8s docker mirror
echo "Adding azk8s Docker mirror..."
mkdir -p /etc/docker

tee /etc/docker/daemon.json <<EOF
{
    "registry-mirrors": [
        "https://dockerhub.azk8s.cn"
    ]
}
EOF

# Add Microsoft repositories and key
echo "Adding Microsoft repositories..."
while true; do
    if curl --retry 5 --retry-delay 5 https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft-archive.gpg; then
        break
    fi
    echo "Failed to download Microsoft key, retrying..."
    sleep 3
done

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
echo "deb [arch=amd64,armhf,arm64] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/microsoft.list

# Update and Upgrade
echo "Updating OS..."
while ! apt-get update && apt-get upgrade -y; do
  echo "Failed to update and upgrade OS. Retrying..."
  sleep 3
done

# echo "Installing Docker..."
# apt-get install -y docker.io

# Installing softwares
echo "Installing common packages..."
while ! apt-get -y install jq unzip zip git wget curl tzdata gnupg ca-certificates apt-transport-https lsb-release software-properties-common postgresql-client gettext-base; do
  echo "Failed to install common packages. Retrying..."
  sleep 3
done

# Install python3 and pip
echo "Installing Python3 and pip..."
while ! apt-get install -y python3 python3-pip; do
  echo "Failed to install Python3 and pip. Retrying..."
  sleep 3
done

# Install powershell and azure cli
echo "Installing PowerShell and Azure CLI..."
while ! apt-get install -y powershell azure-cli; do
  echo "Failed to install PowerShell and Azure CLI. Retrying..."
  sleep 3
done

# Install OpenJDK 11
echo "Installing OpenJDK 11..."
while ! apt-get install -y openjdk-11-jdk; do
  echo "Failed to install OpenJDK 11. Retrying..."
  sleep 3
done

# Cleanup and fix potential issues
apt-get -y autoremove --allow-downgrades
apt-get -y install -f
