#!/usr/bin/env bash

set -e
# Non-interactive installation of packages required for the build agent
export DEBIAN_FRONTEND=noninteractive

# Install custom packages
echo "Getting custom package gpgs..."
mkdir -p /etc/apt/keyrings

curl -sLS https://packages.microsoft.com/keys/microsoft.asc        | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null
curl -sLS https://baltocdn.com/helm/signing.asc                    | gpg --dearmor | tee /etc/apt/keyrings/helm.gpg      > /dev/null
curl -sLS https://apt.releases.hashicorp.com/gpg                   | gpg --dearmor | tee /etc/apt/keyrings/hashicorp.gpg > /dev/null
curl -sLS https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | tee /etc/apt/keyrings/trivy.gpg     > /dev/null
curl -sLS https://mirror.azure.cn/docker-ce/linux/ubuntu/gpg       | gpg --dearmor | tee /etc/apt/keyrings/docker.gpg    > /dev/null

OS_NAME=$(lsb_release -cs)
PACKAGE_ARCH=$(dpkg --print-architecture)
echo "deb [arch=$PACKAGE_ARCH signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli $OS_NAME main"    | tee /etc/apt/sources.list.d/azure-cli.list
# echo "deb [arch=$PACKAGE_ARCH signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod $OS_NAME main"  | tee /etc/apt/sources.list.d/microsoft-prod.list
echo "deb [arch=$PACKAGE_ARCH signed-by=/etc/apt/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main"                    | tee /etc/apt/sources.list.d/helm-stable-debian.list
echo "deb [arch=$PACKAGE_ARCH signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $OS_NAME main"                | tee /etc/apt/sources.list.d/hashicorp.list
echo "deb [arch=$PACKAGE_ARCH signed-by=/etc/apt/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $OS_NAME main"         | tee /etc/apt/sources.list.d/trivy.list
echo "deb [arch=$PACKAGE_ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://mirror.azure.cn/docker-ce/linux/ubuntu $OS_NAME stable"     | tee /etc/apt/sources.list.d/docker.list

# Update and upgrade packages
while ! apt-get update && apt-get upgrade -y; do
  echo "Failed to update and upgrade OS. Retrying..."
  sleep 3
done

# Ubuntu Python packages are outdated, add deadsnakes PPA to get the latest versions
echo "Adding deadsnakes PPA..."
while ! add-apt-repository ppa:deadsnakes/ppa -y; do
  echo "Failed to add deadsnakes PPA. Retrying..."
  sleep 3
done

# Install python3.11 and python3.12
echo "Installing Python 3.11 and 3.12..."
while ! apt-get install -y python3.11 python3.12 pip; do
  echo "Failed to install Python packages. Retrying..."
  sleep 3
done

# Install azure-cli, helm, terraform, trivy
echo "Installing azure-cli, helm, terraform, trivy..."
while ! apt-get install -y azure-cli helm terraform trivy; do
  echo "Failed to install azure-cli, helm, terraform, trivy. Retrying..."
  sleep 3
done

# Install Docker: https://docs.docker.com/engine/install/ubuntu/
echo "Installing Docker..."
while ! apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; do
  echo "Failed to install Docker. Retrying..."
  sleep 3
done

# Install kubectl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
echo "Installing kubectl..."
apt-get update
apt-get install -y kubectl

# Install kubelogin
echo "Installing kubelogin..."
while ! snap install kubelogin; do
  echo "Failed to download kubelogin. Retrying..."
  sleep 3
done

# Install az aks cli
echo "Installing Azure AKS CLI..."
export AZURE_CLI_DISABLE_CONNECTION_VERIFICATION=1
az upgrade --yes

while ! az aks install-cli; do
  echo "Failed to download Azure AKS CLI. Retrying..."
  sleep 3
done

# Install helm-diff plugin
echo "Install helm-diff plugin..."
export HELM_PLUGINS=/usr/local/share/helm/plugins
mkdir -p $HELM_PLUGINS
# helm env
while ! helm plugin install https://github.com/databus23/helm-diff; do
  echo "Failed to install helm-diff plugin. Retrying..."
  sleep 3
done

# Install krew and kyverno plugin
echo "Installing krew and kyverno..."
export KREW_ROOT=/usr/local/share/krew
mkdir -p $KREW_ROOT

(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  while true; do
    if curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
        tar zxvf "${KREW}.tar.gz" &&
        ./"${KREW}" install krew &&
        ./"${KREW}" install kyverno; then
      break
    else
      echo "Installation failed, retrying in 10 seconds..."
      sleep 3
    fi
  done
  chmod go+rx /usr/local/share/krew/store/*/*
)

# Install and configure SDKMAN
echo "Installing SDKMAN..."
export SDKMAN_DIR="/usr/local/sdkman"
curl -sLS "https://get.sdkman.io?rcupdate=false" | bash
source "$SDKMAN_DIR/bin/sdkman-init.sh"
sed -i 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g' "$SDKMAN_DIR/etc/config"

JAVA_17="$(sdk list java | grep -o -E " 17(\.[0-9]+)?(\.[0-9]+)?-tem " | sort -r | head -1 | tr -d '[:blank:]')"
JAVA_21="$(sdk list java | grep -o -E " 21(\.[0-9]+)?(\.[0-9]+)?-tem " | sort -r | head -1 | tr -d '[:blank:]')"
MAVEN_3="$(sdk list maven | grep -o -E " 3(\.[0-9]+)?(\.[0-9]+)? " | sort -r | head -1 | tr -d '[:blank:]')"

# Install Java and Maven using SDKMAN
echo "Installing Java and Maven using SDKMAN..."
while ! sdk install java "$JAVA_17" && ! sdk install java "$JAVA_21"; do
  echo "Failed to install Java. Retrying..."
  sleep 3
done

while ! sdk install maven "$MAVEN_3"; do
  echo "Failed to install Maven. Retrying..."
  sleep 3
done

{
  echo "JAVA_17_HOME=\"$SDKMAN_DIR/candidates/java/$JAVA_17\""
  echo "JAVA_21_HOME=\"$SDKMAN_DIR/candidates/java/$JAVA_21\""
  echo "MAVEN_3_HOME=\"$SDKMAN_DIR/candidates/maven/$MAVEN_3\""
  echo "PYTHON_3_11_PATH=\"/usr/local/python3.11\""
  echo "PYTHON_3_12_PATH=\"/usr/local/python3.12\""
  echo "HELM_PLUGINS=\"$HELM_PLUGINS\""
  echo "KREW_ROOT=\"$KREW_ROOT\""
} >> /etc/environment

# Fix Ubuntu 22.04 libssl incompatibility with Azure DevOps agent .NET version
echo "Fixing Ubuntu 22.04 libssl incompatibility with Azure DevOps agent .NET version..."
wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb &&  dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb && rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sed -i 's/openssl_conf = openssl_init/#openssl_conf = openssl_init/g' /etc/ssl/openssl.cnf
apt-get clean

#### Display more versions ####
echo "...Displaying versions of installed packages..."
echo "POWERSHELL VERSION: $(pwsh --version)"
echo "AZURE-CLI VERSION: $(az version -o table)"
echo "TERRAFORM VERSION: $(terraform --version)"
echo "KUBECTL VERSION: $(kubectl version --client=true)"
echo "KUBELOGIN VERSION: $(kubelogin --version)"
echo "DOCKER VERSION: $(docker --version)"
echo "PYTHON VERSION: $(python3 --version)"
echo "JQ VERSION: $(jq --version)"
echo "GIT VERSION: $(git --version)"
echo "POSTGRESQL CLIENT VERSION: $(psql --version)"