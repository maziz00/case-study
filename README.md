## Microservices platform requirements

emirates microservices platform :



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



## Infrastructure deployment

To deploy the cluster components, Terraform will be used.
I provided Terraform modules code snippets to :
 01 - Prepare the network infrastructure
 02 - Create the security groups
 03 - Deploy the kubernetes master
 04 - Deploy the kubernetes workers
 05 - Deploy the cluster autoscaler
 06 - Deploy an Ingress
 07 - Install a logging and monitoring stacks
 08 - Install rds