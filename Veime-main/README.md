# Veime
Terraform

I wrote the terraform code using modules, this is the structure of the files:

└── .github
    └── workflows
        └── regtech-ci-cd.yml
├── cloudwatch_log
├── modules
│   └── compliance
│   │   └── main.tf
|   |   └── outputs.tf
|   |   └── variebles.tf
│   ├── eks
│   │   └── main.tf
|   |   └── outputs.tf
|   |   └── variebles.tf
|   |   └── providers.tf
│   ├── deployment
│   │   └── deployment.yaml
|   |   └── namespace.yaml
│   └── networking
│   │   └── main.tf
|   |   └── outputs.tf
|   |   └── variebles.tf
|   |   └── providers.tf
│   └── security
├── providers.tf
├── outputs.tf
├── variables.tf
├── terraform.tfvars
└── main.tf



key decisions made during the challenge

EKS Cluster: Chose EKS for its managed Kubernetes offering, simplifying cluster operations and maintenance.
Node Group: Implemented a node group to provide scalability and flexibility for different workloads.
CloudWatch: Chose CloudWatch for its seamless integration with AWS services and cost-effectiveness.
CI/CD: Used GitHub Actions to automate the build and deployment process, ensuring consistent and reliable deployments.
Namespaces: Created separate namespaces for development and staging environments to isolate workloads and manage deployments effectively.



Usage Instructions
Prerequisites:

Install Terraform (version 1.0.0 or higher).
Configure AWS CLI with credentials that have the necessary permissions.
Ensure Git is installed for version control.
Initializing the Project:

Navigate to the root directory of the project.
Run terraform init to initialize the Terraform working directory and download required providers.
Configuring Variables:

Review variables.tf and terraform.tfvars to set appropriate values for your environment.
Key variables include aws_region, environment, cluster_name, etc.
Planning the Deployment:

Run terraform plan to see what resources will be created, modified, or destroyed.
Review the output carefully to ensure it matches your expectations.
Applying the Configuration:

Run terraform apply to create the infrastructure.
Confirm the execution plan when prompted.
Monitoring the CI/CD Pipeline:

Commit and push changes to your GitHub repository.
The regtech-ci-cd.yml workflow will be triggered.
Monitor the workflow in the "Actions" tab of your GitHub repository.
Deploying Applications:

Use the deployment module's manifests to deploy your application to the EKS cluster.
Apply the Kubernetes manifests using kubectl or integrate them into your Terraform configuration using the Kubernetes provider.

Troubleshooting
Common Issues
Authentication Errors:

Verify AWS credentials are correctly set in GitHub Secrets.
Ensure the IAM user has necessary permissions.
Syntax Errors:

Run terraform fmt and terraform validate locally before pushing changes.
Resource Conflicts:

Check for duplicate resource definitions.
Ensure proper use of Terraform state.
Workflow Failures:

Review logs in the GitHub Actions workflow.
Look for error messages and stack traces.





