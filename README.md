# Self-Hosted Azure Devops Agent Images

## 1. Project Background

Azure DevOps pipelines do not support Microsoft-hosted agents in Azure China, forcing organizations to deploy and manage their own self-hosted agents.

This project automates the creation and lifecycle management of a custom OS image for self-hosted Azure DevOps agents using Terraform and Packer. The resulting image is stored in Azure Shared Image Gallery, ensuring consistency, scalability, and simplified maintenance across deployments.

## 2. Resources Created
This project uses Terraform to provision the following infrastructure resources:
- Azure Shared Image Gallery: Manages and shares custom virtual machine images.
- Image Definitions & Versions: Generates specific versions of images as needed.
- Storage Accounts: Stores terraform backend states and custom scripts.
- Role Assignments: Grants necessary permissions to access and manage resources.

This project builds agent image based on Ubuntu 22.04 with multiple development tools for the use of CICD pipelines, such as python, java, docker, kubectl, az-cli, helm, trivy, git, pgsql client, etc.

## 3. Module Directory
Below is a directory of each Terraform module and links to their respective README files:
- [shared_image_gallery module](./modules/shared_image_gallery/README.md)
- [shared_images module](./modules/shared_images/README.md)
- [storage_account module](./modules/storage_account/README.md)

Please refer to the linked README files for detailed module descriptions and usage examples.