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

In this readme file, we will detail the first part:

## Setting up Terraform Backend and Jenkins Server

### Step 1: Create S3 Bucket for Terraform State

Terraform needs to store state information somewhere. We are going to keep it in AWS S3 storage. Head over to your AWS panel and create a bucket. The bucket name has to be unique. For this guide, we'll use the name: `mubin-devops-cicd-terraform-eks`, and the region `us-east-1` (US North Virginia). You can select your preferred region.

### Step 2: Create a Key Pair for Jenkins EC2 Instance

We'll need a key to log in to the Jenkins EC2 instance. In the EC2 dashboard, under **Network & Security**, click on **Key Pairs** and create a new key pair. Name it something like `jenkins-server-key`. Download the `.pem` file and set its permission to `400` by running:

```bash
chmod 400 jenkins-server-key.pem
```

### Step 3: Configure Terraform Backend
We'll use the S3 bucket to store Terraform state by creating a `backend.tf` file. Here's how it works.

# Step 4: Configure AWS Provider
Since we will be using AWS as a cloud provider, configure Terraform with this information. You can find this in the `provider.tf` file [here](#).

# Step 5: Define Terraform Variables
We will need to declare variables for our setup. These are defined in the `variables.tf` file, which you can find [here](#).

Initialize these variables in the `terraform.tfvars` file, found [here](#).

# Step 6: Create Jenkins Server using EC2
We'll set up the Jenkins server using the latest Amazon Linux 2 image. Add the following content to the `server.tf` file, which you can find [here](#).

In the resource block, the `jenkins-server-setup.sh` script is used to initialize packages on our Jenkins server. You can find this script [here](#).

# Step 7: Configure VPC and Networking
To set up networking for the EC2 instance, refer to the `vpc.tf` file [here](#).  
This configuration will create:
- A VPC
- A subnet
- An Internet Gateway (IG)
- A Route table
- A Security Group (SG) allowing SSH (port 22) and Jenkins (port 8080)

> **Note:** It is not recommended to allow all traffic for production environments. For testing purposes, this setup allows access from anywhere, but you can restrict this by adding your public IP in the ingress rules.

# Step 8: Run Terraform Commands
Now that everything is set, let's execute the Terraform scripts.

### Initialize Terraform
Run the following command to initialize Terraform:
```bash
terraform init
```
## Plan the Infrastructure

To preview the infrastructure that will be created, run the following command:

```bash
terraform plan
```

You should see output indicating that 6 resources will be created, including:

- Route table
- Subnet
- Internet gateway
- Security group
- EC2 instance
- VPC

Apply the Infrastructure
To create the infrastructure, apply the plan with:

bash
Copy code
terraform apply --auto-approve
Once complete, you can verify the resources in the AWS console.

Step 9: Set Up Jenkins Server
To access Jenkins, copy the public IP of the EC2 instance and paste it into your browser.

Log in to the EC2 instance via SSH:

bash
Copy code
ssh -i jenkins-server-key.pem ec2-user@<public-ip-of-instance>
Retrieve the default Jenkins admin password:

bash
Copy code
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
Paste the password into the Jenkins setup page and proceed with the setup.

Step 10: Configure Jenkins with GitHub and AWS
Add GitHub Credentials
Go to Manage Jenkins -> Credentials -> Global.
Click Add Credentials and select Username and Password for GitHub.
Add AWS Credentials
Add AWS access and secret keys as Secret Text credentials.
Configure AWS CLI
In the terminal, run the following command and enter your AWS credentials:

b

# Infrastructure Setup and Jenkins Configuration

## Plan the Infrastructure

To preview the infrastructure that will be created, run the following command:

```bash
terraform plan
```
This command will display a preview of the changes Terraform will make to your infrastructure. You should see output indicating that the following 6 resources will be created:

- Route table: Manages the routes for traffic in your VPC.
- Subnet: Defines a range of IP addresses within your VPC.
- Internet gateway: Allows communication between instances in your VPC and the internet.
- Security group: Acts as a virtual firewall to control inbound and outbound traffic to your instances.
- EC2 instance: The virtual server that will run Jenkins.
- VPC: A virtual private cloud to isolate your network resources.

To actually create the infrastructure defined in your Terraform configuration, apply the plan with:

```bash
terraform apply --auto-approve
```
The --auto-approve flag automatically approves the changes without prompting you. Once the command completes, you can verify that the resources have been created by checking the AWS Management Console.

## Set Up Jenkins Server
Access Jenkins:

Copy the public IP address of the EC2 instance from the AWS Management Console.
Paste this IP address into your web browser to access the Jenkins setup page.
Log in to the EC2 Instance:

Connect to your EC2 instance via SSH using the following command:

```bash
ssh -i jenkins-server-key.pem ec2-user@<public-ip-of-instance>
```
Replace <public-ip-of-instance> with the actual public IP of your EC2 instance.

Retrieve the Jenkins Admin Password:

Once logged in, retrieve the default Jenkins admin password with:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Copy the password displayed in the terminal.

Complete Jenkins Setup:

Paste the copied password into the Jenkins setup page in your browser and follow the prompts to complete the initial configuration.
Step 10: Configure Jenkins with GitHub and AWS
Add GitHub Credentials
Navigate to Manage Jenkins -> Credentials -> Global in the Jenkins dashboard.
Click on Add Credentials.
Choose Username with password from the dropdown menu.
Enter your GitHub username and password (or a personal access token if using GitHub's recommended authentication method).
Click OK to save the credentials.
Add AWS Credentials
Go back to Manage Jenkins -> Credentials -> Global.
Click Add Credentials.
Select Secret text from the dropdown menu.
Enter your AWS access key and secret key as separate credentials.
Click OK to save.
Configure AWS CLI
Open a terminal on your local machine or the Jenkins server.

Run the following command to configure the AWS CLI with your AWS credentials:

```bash
aws configure
```
Follow the prompts to enter your AWS access key, secret key, default region, and output format.

## Getting Started

### Step 1: Clone the repository

```bash
git clone https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS.git
cd Terraform_Jenkins_EKS
