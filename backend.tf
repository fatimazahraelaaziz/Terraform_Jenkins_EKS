terraform {
  backend "s3" {
    bucket = "fati-devops-cicd-terraform-eks"
    region = "eu-west-3"
    key    = "jenkins-server/terraform.tfstate"
  }
}
