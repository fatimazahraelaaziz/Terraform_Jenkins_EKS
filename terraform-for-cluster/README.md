# Kubernetes Setup with Terraform and Jenkins

This guide outlines the steps for setting up a Kubernetes cluster using Terraform and Jenkins.

## Terraform Configuration

1. **Provider Configuration**
   - Create [`provider.tf`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/terraform-for-cluster/provider.tf) as in Part 1.

2. **Backend Configuration**
   - Use [`backend.tf`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/terraform-for-cluster/backend.tf) with a different key. Keeping the same key will overwrite the existing Jenkins infrastructure.

3. **Custom VPC Module**
   - Create [`vpc.tf`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/terraform-for-cluster/vpc.tf) for setting up the VPC where the cluster will operate. Configure availability zones, public and private subnets with CIDR blocks from [`terraform.tfvars`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/terraform-for-cluster/terraform.tfvars), and NAT gateways.

4. **EKS Cluster Module**
   - Write [`eks-cluster.tf`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/terraform-for-cluster/eks-cluster.tf) to define the EKS cluster using the VPC module created above.

5. **Terraform Variables**
   - Configure variables in [`terraform.tfvars`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/terraform-for-cluster/terraform.tfvars).

6. **Variable Definitions**
   - Define the variables in [`variables.tf`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/terraform-for-cluster/variables.tf).

## Jenkins Pipeline

1. **Environment Variables**
   - Set environment variables related to AWS.

2. **Pipeline Stages**
   - **Stage 1:** Create a Kubernetes cluster by specifying the directory where Terraform scripts should run.
   - **Stage 2:** Deploy the default Nginx app on Kubernetes, specifying [`kubernetes`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/tree/main/kubernete) as the directory for deployment and service scripts.


