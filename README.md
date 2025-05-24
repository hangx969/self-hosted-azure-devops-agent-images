# Self-Hosted Azure Devops Agent Images

## 1. Project Background
This project aims to automate the creation and management of infrastructure needed for self-hosted Azure devops agents using Terraform. These agents support Azure devops CICD pipelines, offering flexibility and scalability while reducing reliance on third-party hosted services.

## 2. Resources Created
This project uses Terraform to provision the following resources:
- Azure Shared Image Gallery: Manages and shares custom virtual machine images.
- Image Definitions & Versions: Generates specific versions of images as needed.
- Storage Accounts: Stores terraform backend states and custom scripts.
- Role Assignments: Grants necessary permissions to access and manage resources.

## 3. Module Directory
Below is a directory of each Terraform module and links to their respective README files:
- [shared_image_gallery module](./modules/shared_image_gallery/README.md)
- [shared_images module](./modules/shared_images/README.md)
- [storage_account module](./modules/storage_account/README.md)

Please refer to the linked README files for detailed module descriptions and usage examples.