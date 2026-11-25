AWS Terraform Infrastructure – Sudoku Application

A production-style AWS infrastructure project that automates the deployment of a Sudoku web application using Terraform, Docker, Amazon ECR, GitHub Actions and AWS services.

The project demonstrates Infrastructure as Code (IaC), automated CI/CD, secure AWS authentication using GitHub OIDC, high availability and application health verification.

Architecture Overview

The application is deployed on AWS in the ap-south-1 region across two Availability Zones.

Infrastructure Components

| Component | Purpose |
|---|---|
| Amazon VPC | Isolated cloud network |
| Public Subnets | Host the Application Load Balancer and NAT Gateway |
| Private Application Subnets | Host application EC2 instances |
| Private Database Subnets | Isolate the RDS database |
| Application Load Balancer | Distributes incoming application traffic |
| EC2 Auto Scaling Group | Maintains application instances |
| Launch Template | Defines EC2 instance configuration |
| Amazon RDS MySQL | Managed relational database |
| Amazon ECR | Stores Docker container images |
| IAM Roles | Provides controlled AWS permissions |
| NAT Gateway | Enables outbound internet access from private subnets |

High-Level Architecture


flowchart TD
    A[Developer] --> B[GitHub Repository]
    B --> C[GitHub Actions CI/CD]
    C --> D[AWS OIDC Authentication]
    D --> E[Docker Build]
    E --> F[Amazon ECR]
    C --> G[Terraform Plan and Apply]
    G --> H[VPC - Two Availability Zones]
    F --> I[EC2 Auto Scaling Group]
    H --> I
    I --> J[Application Load Balancer]
    J --> K[Users]
    I --> L[Amazon RDS MySQL]


Technology Stack

- Cloud: Amazon Web Services (AWS)
- Infrastructure as Code: Terraform
- Containerization: Docker
- Container Registry: Amazon ECR
- CI/CD: GitHub Actions
- Authentication: AWS IAM and GitHub OIDC
- Compute: Amazon EC2 and Auto Scaling
- Networking: VPC, Subnets, Route Tables, NAT Gateway
- Load Balancing: Application Load Balancer
- Database: Amazon RDS MySQL
- Version Control: Git and GitHub

CI/CD Pipeline

The project uses GitHub Actions to automate the application deployment process.

Deployment Workflow

1. Developer pushes changes to the main branch.
2. GitHub Actions starts the CI/CD workflow.
3. AWS authentication is established using GitHub OIDC.
4. Docker builds the application image.
5. The image is pushed to Amazon ECR using the Git commit SHA as its tag.
6. Terraform initializes the backend and prepares the infrastructure plan.
7. Terraform applies the infrastructure changes.
8. EC2 Auto Scaling performs an instance refresh to deploy the updated application.
9. The workflow waits for the refresh to complete.
10. Application Load Balancer target health is verified.

The workflow completes only after the required application targets become healthy.

Security Implementation

- GitHub OIDC authentication instead of long-lived AWS access keys.
- IAM roles and policies for controlled access.
- Separate IAM permissions for ECR image operations.
- EC2 instance roles for AWS service access.
- Private application and database subnets.
- Security groups to control network traffic.
- Terraform remote state stored separately from the application infrastructure.

Terraform Project Structure


aws_terra-infra/
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── app/
│   └── Dockerfile
│
├── bootstrap/
│   └── github-oidc/
│
├── modules/
│   ├── alb/
│   ├── ec2/
│   ├── ecr/
│   ├── rds/
│   ├── security/
│   └── vpc/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── backend.tf
├── terraform.tfvars
├── .gitignore
└── README.md


Deployment Instructions

Prerequisites

- AWS account
- Terraform CLI
- AWS CLI
- Docker
- Git
- GitHub repository

 1. Clone the repository

git clone https://github.com/manipaluniversitymentor257-star/aws_terra-infra.git

cd aws_terra-infra

 2. Configure AWS authentication

Configure the GitHub OIDC identity provider, IAM role and required permissions before running the GitHub Actions workflow.

Do not commit AWS access keys, secret keys or sensitive configuration files.

 3. Initialize Terraform

terraform init


 4. Validate the configuration


terraform fmt -recursive
terraform validate


 5. Review the infrastructure plan

terraform plan

 6. Deploy the infrastructure

terraform apply

 7. Access the application

Retrieve the Application Load Balancer DNS name:

terraform output -raw alb_dns_name

Open the resulting DNS address in a browser.

 Deployment Verification

The successful deployment was verified through:

- Successful GitHub Actions workflow execution.
- Successful Docker image push to Amazon ECR.
- Successful Terraform apply.
- Successful EC2 Auto Scaling instance refresh.
- Two healthy targets in the Application Load Balancer target group.
- Successful application access through the ALB DNS endpoint.

Infrastructure Cleanup

To remove Terraform-managed AWS infrastructure:

terraform destroy

Important: This removes the resources managed by this Terraform configuration, including the RDS database, ECR repository and application infrastructure.

Back up any required database data and preserve the separately managed Terraform state backend before destroying the infrastructure.

Key Learning Outcomes

- Designing AWS infrastructure across multiple Availability Zones.
- Building reusable Terraform modules.
- Automating infrastructure provisioning.
- Implementing GitHub Actions CI/CD.
- Configuring secure AWS authentication using OIDC.
- Building and publishing Docker images to Amazon ECR.
- Deploying application updates through EC2 Auto Scaling.
- Implementing load balancing and health checks.
- Troubleshooting real-world IAM, Docker and deployment issues.



Project: AWS Terraform Infrastructure – Sudoku Application

Repository: [aws_terra-infra](https://github.com/manipaluniversitymentor257-star/aws_terra-infra)
