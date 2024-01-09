# Project Name

This repository contains Terraform scripts to deploy infrastructure on AWS for a multi-environment setup.

## Overview

The Terraform scripts in this repository create a multi-region setup on AWS using modularized components for different environments (dev, prod).

### Components Created

- **VPCs**: Separate VPCs for Dev and Prod environments
- **security groups**: outbound and inbound rules for the ec2 instances
- **EC2 Instances**:
  - Dev Environment: Two Ubuntu instances in eu-west-1 region, spread across two availability zones
  - Prod Environment: Two Ubuntu instances in eu-central-1 region, spread across two availability zones

### Configuration

The Terraform configuration is organized into modules:

- **VPC Module**: Handles the creation of VPCs for different environments.
- **Instance Module**: Creates EC2 instances with provisioners to install Ansible and Docker.
- **security groups modules**: sets the rules for both outgoing and incoming traffic

## Usage

### Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) installed.
2. AWS credentials configured.

### Instructions

1. Build the terraform script with the help of the official terraform documentation :
      search for aws terraform documentation on any resource
    ```bash
   https://registry.terraform.io/
    ```

2. Initialize Terraform:

    ```bash
    terraform init
    ```

3. Modify `variables.tf` to set appropriate values (e.g., AMI IDs, key names).
4. Run Terraform to create the infrastructure:

    ```bash
    terraform apply
    ```

## Structure

The repository structure is as follows:
- **DEV enviroments**: Handles the creation of VPCs for different environments.
  - `main.tf`: Main Terraform script orchestrating modules.
  - `variables.tf`: Definition of variables used in the Terraform configuration.
  - `backend.tf` : aws s3 bucket to store the .tfstate file remotely
  - `dev.auto.tfvars` : value of each variables is inputed 
- **PROD enviroments**: Creates EC2 instances with provisioners to install Ansible and Docker.
  - `main.tf`: Main Terraform script orchestrating modules.
  - `variables.tf`: Definition of variables used in the Terraform configuration.
  - `backend.tf` : aws s3 bucket to store the .tfstate file remotely
  - `dev.auto.tfvars` : value of each variables is inputed 
- `modules/`: Directory containing modularized Terraform scripts.
  - `vpc/`: Module for VPC creation.
  - `instance/`: Module for EC2 instance creation.
  - `security-groups/` : module for security groups for outbound and inbound rules.


