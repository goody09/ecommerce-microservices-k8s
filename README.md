# Socks Shop Microservices Deployment on Kubernetes

![Your paragraph text (9)](https://github.com/user-attachments/assets/087d8ec5-9c8d-4e68-86df-fde35cbf48fb)

## Overview

This project deploys the Socks Shop microservices application on Kubernetes using a fully automated Infrastructure as Code (IaC) approach. The deployment process is managed through GitHub Actions, which automates the creation of infrastructure, application deployment, and teardown. The project also integrates monitoring, logging, and security features, ensuring that the application is robust and secure.

## Features

- **Automated IaC Deployment**: Uses Terraform and GitHub Actions to automate infrastructure provisioning and application deployment.
- **Comprehensive Monitoring**: Implements Prometheus for monitoring, Grafana for visualizations, and Alertmanager for alert management with Slack notifications.
- **Security**: Secures communication with HTTPS using Let's Encrypt.
- **Scalability**: Deployed on Kubernetes, allowing for easy scaling and management of microservices.

## Architecture

The architecture includes the following components:

1. **Kubernetes Cluster**: Managed by AWS EKS (Elastic Kubernetes Service), the cluster hosts the microservices that make up the Socks Shop application.
2. **Terraform**: Used to provision the infrastructure, including the EKS cluster, VPC, S3 bucket, and DynamoDB table.
3. **Helm**: Manages the deployment of applications and services within the Kubernetes cluster.
4. **Prometheus**: Monitors the performance and health of the microservices, Kubernetes resources, and other critical infrastructure.
5. **Grafana**: Provides a user-friendly interface for visualizing metrics collected by Prometheus.
6. **Alertmanager**: Manages alerts triggered by Prometheus, with notifications sent to Slack.
7. **Let's Encrypt**: Automatically provisions SSL certificates to secure the application with HTTPS.
8. **Nginx Ingress Controller**: Manages external access to the services within the Kubernetes cluster, including load balancing and HTTPS termination.

## Repository Structure

```plaintext
SOCK-SHOP-MS/
├── .github/
│   └── workflows/                         # GitHub Actions workflows for CI/CD automation.
│       ├── actions.yml                     # Workflow for deploying infrastructure and applications.
│       └── destroy.yml                    # Workflow for tearing down infrastructure and applications.
├── encrypt-chart/
│   └── templates/
│       ├── cert-issue.yml                 # Kubernetes manifest for issuing SSL certificates using Let's Encrypt.
│       ├── .helmignore                    # Files and directories to ignore when packaging Helm charts.
│       ├── Chart.yaml                     # Metadata file for the Helm chart (encrypt chart).
│       └── values.yaml                    # Default configuration values for the encrypt Helm chart.
├── ingress-chart/
│   └── templates/
│       ├── .helmignore                    # Files and directories to ignore when packaging the ingress Helm chart.
│       ├── Chart.yaml                     # Metadata file for the Helm chart (ingress chart).
│       └── values.yaml                    # Default configuration values for the ingress Helm chart.
├── manifest-alertconfig/
│   ├── alertmanagerconfig.yml             # Configuration for Alertmanager, defining alert routing and receivers.
│   ├── probes.yml                         # Kubernetes readiness and liveness probes for monitoring application health.
│   └── rules.yml                          # Alerting rules defining when alerts should be triggered.
├── manifest-prometheus/
│   └── values.yaml                        # Configuration values for Prometheus, including scraping and alerting.
├── sock-shop-chart/
│   └── templates/
│       ├── deployment.yml                 # Kubernetes Deployment manifest for the Sock Shop microservices.
│       ├── namespace.yml                  # Namespace definition for isolating the Sock Shop application.
│       ├── service.yml                    # Kubernetes Service manifest to expose the Sock Shop application.
│       ├── .helmignore                    # Files and directories to ignore when packaging the Sock Shop Helm chart.
│       ├── Chart.yaml                     # Metadata file for the Sock Shop Helm chart.
│       └── values.yaml                    # Default configuration values for the Sock Shop Helm chart.
└── terraform_code/
    ├── backend.tf                         # Terraform backend configuration, using S3 and DynamoDB for state management.
    ├── terraform.tfvars                   # Terraform variable values, including S3 bucket and DynamoDB table names.
    ├── eks.tf                             # Terraform configuration to provision the EKS cluster.
    ├── provider.tf                        # Provider configuration, defining AWS as the cloud provider.
    ├── variables.tf                       # Variables file to store configurable values like region, cluster name, etc.
    └── vpc.tf                             # Terraform configuration to provision the VPC for the Kubernetes cluster.
```

## Setup and Deployment

### Step 1: Fork and Clone the Repository

```bash
git clone https://github.com/busybrainx99/sock-shop-ecommerce.git
cd sock-shop-ecommerce
```

### Step 2: Configure GitHub Secrets

In your GitHub repository, set up the following secrets:

- **AWS_ACCESS_KEY_ID**: Your AWS Access Key ID.
- **AWS_SECRET_ACCESS_KEY**: Your AWS Secret Access Key.
- **SLACK_WEBHOOK_URL**: The Slack webhook URL for notifications.
- **CLUSTER_NAME**: The name of your Kubernetes cluster.
- **DYNAMODB_TABLE_NAME**: The name of your DynamoDB table for state locking.
- **REGION**: The AWS region where your resources are deployed.
- **S3_BUCKET_NAME**: The name of the S3 bucket for storing Terraform state.

### Step 3: Trigger the Deployment Workflow

Navigate to the "Actions" tab in your GitHub repository and select the `deploy.yml` workflow. You can trigger this workflow manually to begin the deployment process.

### Step 4: Verify Deployment

- **Infrastructure**: The workflow will first set up the infrastructure using Terraform, creating the EKS cluster, VPC, S3 bucket for state storage, and DynamoDB table for state locking.
- **Kubernetes Configuration**: The kubeconfig is updated to allow interaction with the newly created Kubernetes cluster.
- **Application Deployment**: The Helm charts for the Sock Shop application, Let's Encrypt, Prometheus, and Nginx Ingress Controller are deployed. Grafana is set up for monitoring.
- **HTTPS and Ingress**: The Nginx Ingress Controller creates a load balancer, and ingress rules are applied to expose the Sock Shop application over the web, secured with HTTPS via Let's Encrypt.

### Step 5: Monitoring and Alerts

- **Prometheus and Grafana**: Prometheus monitors the cluster, including the application pods, and Grafana visualizes the collected metrics. The setup includes Blackbox Exporter to monitor the uptime and availability of services. Prometheus also tracks other Kubernetes resources, such as CPU and memory usage, network traffic, and pod health.
- **Alertmanager**: Configured alerts notify Slack of any issues or when the workflow is successfully completed.

## SCREENSHOTS OF CREATED RESOURCES

### Github actions executing workflows

<img width="1436" alt="Screenshot 2024-08-13 at 16 47 53" src="https://github.com/user-attachments/assets/f223513e-b9d5-40e3-9358-54ef4bf291a2">

### Notification from Slack

<img width="1436" alt="Screenshot 2024-08-12 at 10 37 30" src="https://github.com/user-attachments/assets/d399e0b4-944a-4dbd-a113-47d0d2653455">
<img width="755" alt="Screenshot 2024-08-10 at 19 22 54" src="https://github.com/user-attachments/assets/db5cc2f3-4af0-4510-91e8-a9932b3ed753">

### Image of s3 bucket to store statefile

<img width="1438" alt="Screenshot 2024-08-12 at 11 07 08" src="https://github.com/user-attachments/assets/c5794589-500f-4d2b-9fa6-cda4d9bf5242">
<img width="1439" alt="Screenshot 2024-08-12 at 16 29 06" src="https://github.com/user-attachments/assets/1fc6aa14-43ca-4bc2-b813-46822a8d9907">

### Image of Dynamodb to store statelock file

<img width="1437" alt="Screenshot 2024-08-12 at 11 07 29" src="https://github.com/user-attachments/assets/17cc673b-2fe6-412d-9f2f-d4f08a5077e7">
<img width="1440" alt="Screenshot 2024-08-12 at 16 29 27" src="https://github.com/user-attachments/assets/8dce1794-a203-4146-9969-7cc0837536b4">

### Images of cluster resources

<img width="1439" alt="Screenshot 2024-08-12 at 11 05 11" src="https://github.com/user-attachments/assets/8a541887-5656-418e-8762-436b552d3d07">
<img width="720" alt="Screenshot 2024-08-10 at 19 41 03" src="https://github.com/user-attachments/assets/fc849929-2214-4cd5-b2be-c000569df2dc">

### I provisioned different EC2 instances on different occasions because using certain resources usage require high node resources.

<img width="1432" alt="Screenshot 2024-08-12 at 16 30 01" src="https://github.com/user-attachments/assets/5c99d6c8-97b0-4952-91aa-8ed106f5728c">

### Second Node Case

<img width="1438" alt="Screenshot 2024-08-12 at 11 04 30" src="https://github.com/user-attachments/assets/93eb8c02-650f-4a99-80de-6976ee03c195">
<img width="1436" alt="Screenshot 2024-08-12 at 16 28 11" src="https://github.com/user-attachments/assets/9954e6fe-cead-4aee-8470-e5fccab8c835">

<img width="1438" alt="Screenshot 2024-08-12 at 16 28 17" src="https://github.com/user-attachments/assets/7eb5cf19-3872-4ae5-92e5-a032bd35998a">

<img width="1438" alt="Screenshot 2024-08-12 at 16 28 25" src="https://github.com/user-attachments/assets/d6692ba3-b411-4107-8e8c-62d3c8782203">

<img width="1424" alt="Screenshot 2024-08-12 at 16 28 37" src="https://github.com/user-attachments/assets/b8b0e9a9-6f6a-4032-87c0-382f2ff1b521">
<img width="1440" alt="Screenshot 2024-08-12 at 16 30 21" src="https://github.com/user-attachments/assets/52b34f66-6e90-4ead-90c6-07931e74bf7d">
<img width="1438" alt="Screenshot 2024-08-12 at 16 30 52" src="https://github.com/user-attachments/assets/68688a50-231c-41a8-98a9-c1c683230b0a">
<img width="1440" alt="Screenshot 2024-08-12 at 16 48 13" src="https://github.com/user-attachments/assets/168d3067-3cd4-483b-bfb5-a395ef0f70fe">

<img width="1420" alt="Screenshot 2024-08-12 at 16 48 28" src="https://github.com/user-attachments/assets/366c5943-7579-43c6-8330-b832b5393be5">

### Namespaces

<img width="418" alt="Screenshot 2024-08-12 at 16 32 50" src="https://github.com/user-attachments/assets/1e2a8018-d493-475e-8fe8-77337deeeb83">

### Deployed resources including the deployement pods and services and ingress controller all craeted in namespace "sock-shop"

<img width="1424" alt="Screenshot 2024-08-12 at 16 32 29" src="https://github.com/user-attachments/assets/5233ba4f-d62e-4121-8a24-d0e66c6d1dfc">
<img width="1439" alt="Screenshot 2024-08-12 at 16 32 34" src="https://github.com/user-attachments/assets/de75fbd5-b5b8-4642-905d-ac7269798c82">

### Some Cert Manager resources for lets encrypt

<img width="511" alt="Screenshot 2024-08-12 at 16 33 26" src="https://github.com/user-attachments/assets/ebcefe25-199d-471c-98c1-ad2cac9e7954">
<img width="616" alt="Screenshot 2024-08-12 at 16 33 58" src="https://github.com/user-attachments/assets/cb86001e-4834-4a11-b726-8681ee2e919c">

### Encryption Proof

<img width="936" alt="Screenshot 2024-08-12 at 16 35 35" src="https://github.com/user-attachments/assets/6e32694b-c505-4e7e-a22f-0affa58cc52b">

### Setting Loadbalancer DNS in my domain register

<img width="1438" alt="Screenshot 2024-08-12 at 16 11 40" src="https://github.com/user-attachments/assets/57e3fa2d-c9d3-4637-9126-da67877006d3">

## FrontEnd of Website deployed

<img width="1443" alt="Screenshot 2024-08-11 at 01 04 00" src="https://github.com/user-attachments/assets/c3900595-20f0-4b49-96df-02afb57e9435">

<img width="718" alt="Screenshot 2024-08-08 at 15 21 41" src="https://github.com/user-attachments/assets/c1b1af1c-8f28-4ceb-bc76-4b727506f6a2">

<img width="718" alt="Screenshot 2024-08-08 at 15 21 30" src="https://github.com/user-attachments/assets/ea05f795-dc2e-479d-bd00-d1d8efdf5564">

<img width="723" alt="Screenshot 2024-08-08 at 15 21 15" src="https://github.com/user-attachments/assets/0ee6d857-eba7-4ec9-9940-9718c7590bf4">

### Prometheus, grafana and alert manager deployed

<img width="1022" alt="Screenshot 2024-08-12 at 16 34 20" src="https://github.com/user-attachments/assets/35edb816-2f3d-49da-8918-c6fe65ef5d13">

## Grafana UI

<img width="1438" alt="Screenshot 2024-08-09 at 14 41 24" src="https://github.com/user-attachments/assets/df6a6656-e31b-4a29-afb3-36c49fbed002">

<img width="1440" alt="Screenshot 2024-08-12 at 10 54 32" src="https://github.com/user-attachments/assets/7c4d32d6-39e6-4ffa-82e2-b3c2a0c35198">

<img width="1436" alt="Screenshot 2024-08-12 at 10 54 49" src="https://github.com/user-attachments/assets/bd160af0-b6a8-4c44-8e6f-be6685ea28a7">

## Prometheus UI

<img width="1433" alt="Screenshot 2024-08-07 at 18 41 21" src="https://github.com/user-attachments/assets/9bcd11ef-1fab-4d22-b96f-d988197c8909">
<img width="1436" alt="Screenshot 2024-08-11 at 01 04 49" src="https://github.com/user-attachments/assets/7b60eef9-0a5e-438d-839b-faa40785a091">
<img width="1431" alt="Screenshot 2024-08-11 at 01 04 29" src="https://github.com/user-attachments/assets/b3cbb4b8-d11f-4b72-ae49-9e02276e2b74">
<img width="1439" alt="Screenshot 2024-08-10 at 19 39 37" src="https://github.com/user-attachments/assets/caf12de2-6532-40fc-a5ad-d05e6c2becbd">
<img width="717" alt="Screenshot 2024-08-10 at 19 38 04" src="https://github.com/user-attachments/assets/0974da13-0a17-49e5-a28f-51a4990f74e2">

## Alert Manager Sending alerts to slack during downtimes and when issues get resolved

<img width="1433" alt="Screenshot 2024-08-12 at 10 47 47" src="https://github.com/user-attachments/assets/c4daba6d-5969-4b2f-ab89-227791c1db3f">
<img width="698" alt="Screenshot 2024-08-12 at 10 43 38" src="https://github.com/user-attachments/assets/17621a88-67ab-4706-8bbb-b1382ef4130b">

<img width="1440" alt="Screenshot 2024-08-12 at 10 44 00" src="https://github.com/user-attachments/assets/060dc3b6-163f-431b-b925-bc3f39075d72">
<img width="673" alt="Screenshot 2024-08-12 at 10 40 12" src="https://github.com/user-attachments/assets/c1f9dde0-49b7-43b6-9527-e5a56fb33459">

## Alert Manager UI. (Removed it from final configuration)

<img width="1429" alt="Screenshot 2024-08-07 at 21 05 36" src="https://github.com/user-attachments/assets/043e9d6c-724b-44f2-9681-3eb3ec4467c3">

## Summary of Resources

- **Terraform**: Handles infrastructure provisioning, including the creation of the Kubernetes cluster, VPC, and associated networking components.
- **Helm**: Manages the deployment of the application and related services within Kubernetes.
- **Prometheus**: Collects metrics on the performance and health of the application and Kubernetes resources.
- **Grafana**: Provides a dashboard for visualizing metrics collected by Prometheus.
- **Alertmanager**: Routes alerts to Slack based on configured rules and probes.
- **Let's Encrypt**: Automates the issuance of SSL certificates for securing web traffic.
- **Nginx Ingress Controller**: Manages external access to the application, ensuring secure, HTTPS-based communication.

## Conclusion

This project provides a fully automated, scalable, and secure deployment of the Socks Shop microservices application on Kubernetes, with comprehensive monitoring, logging, and alerting built-in. The use of GitHub Actions for CI/CD ensures that the deployment and management process is streamlined and easily replicable.

## Contributing

Contributions to this project are welcome. Please adhere to the guidelines outlined in the contributing section of this repository.
