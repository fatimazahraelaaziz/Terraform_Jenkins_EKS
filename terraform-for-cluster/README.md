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

## Deployment Files

In the [`kubernetes`](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/blob/main/kubernetes) directory, you will find:

- **Deployment File**: [deployment.yaml](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/blob/main/kubernetes/deployment.yaml)
- **Service File**: [service.yaml](https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS/blob/main/kubernetes/service.yaml)

## Setting Up Jenkins Pipeline

1. Go to the Jenkins panel. From the dashboard, click **“New Item”** from the left side menu.
2. In the new screen, give a name, select **“Pipeline”**, and click **OK**. This will create a pipeline.
3. Scroll down to the **Pipeline** field. Select **“Pipeline script from SCM”**.
4. Choose **“Git”** as the SCM option.
5. Enter the repository URL: (`https://github.com/fatimazahraelaaziz/Terraform_Jenkins_EKS`)in my case.
6. In **Credentials**, select the Git credentials that were created earlier in Jenkins.
7. Change the branch to **“*/main”** instead of **“*/master”**.
8. In the **Script** field, specify the location of the Jenkinsfile, e.g., `part2-cluster-from-terraform-and-jenkins/Jenkinsfile`.
9. Click **“Save”**.

## Running the Pipeline

1. Go to the created Jenkins pipeline in the web browser.
2. Click **“Build Now”** from the left menu of the pipeline to start setting up EKS.

   The setup process will take approximately 15 minutes.

3. Once the build shows a **“success”** message, go to the **EKS** section on the AWS console to see the created cluster.
4. In the AWS console, navigate to **S3** to find a new folder named **“eks”** and a Terraform state file related to the EKS cluster.
5. Go to **EC2** to find the LoadBalancer. Click on it to view the DNS name in the description section. Copy the DNS name, paste it in your browser, and you should see the Nginx application running.

## Clean Up

To remove the resources created (since LoadBalancers incur costs), navigate to the directory where the second part of the Terraform scripts is located on your local system and run:

```bash
terraform destroy -auto-approve