# Get the latest version of Azure DevOps Agent
echo -e "\nGetting latest Azure Devops agent version and installing Azure DevOps Agent..."
LATEST_VERSION=$(curl --silent "https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest" | jq -r .tag_name | tr -d 'v')
VERSION=$LATEST_VERSION

# Use new CDN URL for agents: https://devblogs.microsoft.com/devops/cdn-domain-url-change-for-agents-in-pipelines/
#PKG_URL="https://vstsagentpackage.azureedge.net/agent/$VERSION/vsts-agent-linux-x64-$VERSION.tar.gz"
PKG_URL="https://download.agent.dev.azure.com/agent/$VERSION/vsts-agent-linux-x64-$VERSION.tar.gz"

DIR="/devopsagent"
mkdir -p $DIR

echo "Downloading and Extracting Azure DevOps Agent - Software Version \"$VERSION\"..."
echo "URL: $PKG_URL "

# Download and extract in one command with retry mechanism
while true; do
    curl -L $PKG_URL | tar xz -C $DIR
    if [ $? -eq 0 ]; then
        break
    else
        echo "Download or extraction failed. Retrying..."
        sleep 5
    fi
done

# Check if extraction was successful
#if [ $? -eq 0 ]; then
echo -e "Extraction successful!\n"

# Removing the tar.gz file if it exists. Though since we piped directly, it shouldn't exist.
if [ -f "$DIR/vsts-agent-linux-x64-$VERSION.tar.gz" ]; then
    rm "$DIR/vsts-agent-linux-x64-$VERSION.tar.gz"
    echo "Removed the .tar.gz file."
fi

# else
#     echo "Failed to extract the Azure DevOps Agent package."
#     exit 1
# fi