## Microservices platform requirements

emirates microservices platform :
 - Must be scalable according to the load 
 - Need to be automatized 
 - Need to be distributed 
 - Need to have mechanism for resiliency and fault tolerance


## Target platform

To meet emirates requirements, the best solution would be a platform based on Kubernetes clusters. Because :
 - kubernetes will control which server will host the container, how it will be launched ...
 - Kubernetes offers security, networking and storage services
 - Kubernetes checks constantly the health of nodes and containers
 - Kubernetes allows scaling resources not only vertically but also horizontally, easily and quickly
 - Kubernetes mounts and add storage system of your choice to run apps
 - Kubernetes can help in performing deployments with automatic scheduling, service detection, and load balancing. If after a change to the application something goes wrong, Kubernetes will be able to rollback
 - Kubernetes always knows where to place containers, by calculating the “best location” for them
 - Kubernetes is an open source tool and gives the freedom to take advantage of on-premises, hybrid, or public cloud infrastructure, letting move workloads to anywhere possible
 - Maintaining resilience and fault tolerance becomes easier and effective with Kubernetes


## Target architecture

The target architecture of the new platform will be based on Kubernetes.
But managing and maintaining kubernetes clusters provisioned the hard-way will apply a lot of resources and huge costs especially when resiliency and fault-tolerance of the clusters highly matter.

AWS provides a Kubernetes managed service (EKS) where the most important components of the control plane (API Server et ETCD) are already highly available.
Amazon EKS runs and scales the Kubernetes control plane across multiple AWS Availability Zones to ensure high availability. Amazon EKS automatically scales control plane instances based on load, detects and replaces unhealthy control plane instances, and automatically patches the control plane. 
The EKS control plane consists of at least two API server instances and three etcd instances that run across three Availability Zones within an AWS Region

In the document "emirates-eks-architecture.pptx", I provided a simplified (and not complete) architecture for the kubernetes cluster to build based on the AWS EKS Service.
The cluster will be in the AWS region "me-south-1" (Bahrein) and composed principally like below :
  a - VPC with three public and three private subnets with one public and one private subnet in each availablity zone
  b - Bastion machine in a public subnet (accessible only via SSH) to enable SSH access to the kubernetes worker nodes in private subnets (for high-availibility of the Bastion machine, we can install two Bastion instances in two different public subnets fronted by a NLB)
  c - Kubernetes master provided as a service by AWS
  d - Kubernetes workers which should run in the private subnets (in different AZ) managed by an Autoscaling group (the node group and the launch template depends on the need of the company. A specific study should be done based on the need)
  e - Metrics server to install in the cluster for metrics export (to the dashboard, the cluster autoscaler, replication controller, Prometheus, ClowdWatch...)
  f - Ingress for trafic forwarding and SSL/TLS endpoint fronted by an ELB 
  g - Velero for backup/restore of the cluster components
  h - a set of tools for logging/monitoring installed using Helm charts

NB: Security aspects (NAT gateways, Internet gateways, routing, security groups, network policies, IAM roles and access policies are not taken into account in this simple and quick approach. But this is a huge part to add...)


## Infrastructure deployment

To deploy the cluster components, Terraform will be used.
I provided Terraform modules code snippets to :
 a - Prepare the network infrastructure
 b - Create the security groups
 c - Deploy the kubernetes master
 d - Deploy the kubernetes workers
 e - Deploy the cluster autoscaler
 f - Install the metrics server and Kubernetes dashboard
 g - Deploy an Ingress
 h - Install a backup/restore solution
 i - Install a logging and monitoring stacks for observability aspects in the cluster
 j - Install a replicated RDS database (in case of need)

I provided also Jenkins pipelines snippets to provision and destroy the infrastructure using the Terraform modules.


## Microservices deployment

To automate the deployment of the microservices, I used Helm charts stored in Github and deployed via Jenkins pipelines using Helm.
For more examples, some components of the cluster are already deployed with Helm like the monitoring/logging stacks components.

NB: We can adopt another approach much more automated to deploy microservices to the Kubernetes cluster using Flux or ArgoCD operators directly from Github to the cluster. I can provide more details on this point in the next interview.


## Monitoring approach

As emirates strategy is to use opensource tools, Prometheus & Grafana are the best monitoring tools to meet this goal.
Used in combination with some AWS services like CloudWatch and SNS, they could handle a lot of monitoring and alerting aspects for the cluster health and its components and deployed applications.
I provided some snippets to install and configure them in the cluster.

NB: No enough time to go deeper with monitoring and alerting configurations