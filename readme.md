# Helloworld Application
Helloworld application is a simple backend services that 
when requesting on ```/helloworld``` return ```{"hello":"world"}```


## Build and Test
You can find more information on [services/backend](./services/backend/readme.md)

## Architecture
Helloworld is installed on a EKS server with 2 nodes and  3 replicas of the microservice using kubernetes healthchecks for availability and AWS ALB as a high availlable load balancer with automatic generated self-signed TLS certificate (I decided to just deploy self-signed cert as making real valid cert requires to deploy a domain that will make test this proof of concept more complex)

All the system is 100% automated deployed and destroyed using terraform and helm.

Continuous Integration of helloworld applications happens on github using github actions and pushing a public image on docker hub.

![System design](./docs/diagram.svg)

## Installation

### Prerequisites
1. terraform v0.13.5 [download](https://releases.hashicorp.com/terraform/0.13.5/)
2. aws cli installed and configured with an account [details](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
3. aws-iam-authenticator installed [details](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
4. kubectl [details](https://kubernetes.io/es/docs/tasks/tools/install-kubectl/)

### Instructions

```
#Check you have all the applications needed installed
make preflight

#login to your AWS account with your access key ID & secret access key.
make login

#initialize infrastructure deployment requirements
make init

#Deploy infrastructure
make deploy

#Test Deployment is OK
make test
```
At this point you have the cluster with the application up and running!

Terraform will output your kubeconfig and application URL on output folder

### Destroying all the infrastructure
```
make destroy
```

## Production notes
Go to [Production notes](./production.md) for more details about production readiness.