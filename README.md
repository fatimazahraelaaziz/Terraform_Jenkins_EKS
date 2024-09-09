# Terraform Jenkins EKS Setup

This project provides an automated solution to set up an **EKS cluster** using **Terraform** and a **Jenkins pipeline**. The project consists of two parts:

1. **Setting up Jenkins server** using Terraform.
2. **Setting up EKS** with Terraform and configuring the Jenkins pipeline for automating cluster deployments.

## Prerequisites

Before proceeding, ensure the following tools are installed and configured on your local system:

- **Terraform** 
- **AWS CLI** 
- AWS credentials properly configured (`aws configure`).

## Project Structure

- **Part 1: Setting up Jenkins Server using Terraform**
  
  This part involves the deployment of a Jenkins server using Terraform. The setup includes:
  
  - Creation of an EC2 instance for Jenkins.
  - Security groups, roles, and necessary IAM permissions.

  All the code and configuration files for this part can be found in the root of this repository.

- **Part 2: EKS Setup and Jenkins Pipeline**
  
  The second part covers the setup of an EKS cluster using Terraform, followed by configuring Jenkins pipelines for automating Kubernetes deployments.
  
  - EKS Cluster creation using Terraform.
  - Configuring Jenkins to deploy into the Kubernetes cluster.

  More details about the configuration can be found in the following directories:
  
  - [Terraform for Cluster Setup](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/terraform-for-cluster)
  - [Kubernetes Setup](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/kubernetes)

## Getting Started

### Step 1: Clone the repository

```bash
git clone https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS.git
cd Terraform_Jenkins_EKS
