# Helloworld Application

![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/segator/full-deploy-example/backend/master)
[![Issues](https://img.shields.io/github/issues-raw/segator/full-deploy-example.svg?maxAge=25000)](https://github.com/segator/full-deploy-example/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/segator/full-deploy-example.svg?style=flat)]()
[![GitHub contributors](https://img.shields.io/github/contributors/segator/full-deploy-example.svg?style=flat)]()

Helloworld application is a simple backend services that 
when requesting on ```/helloworld``` return ```{"hello":"world"}```



## Build and Test
You can find more information on [services/backend](./services/backend/readme.md)

## Architecture
Helloworld is installed on a EKS server with 2 nodes and 5 replicas of the helloworld microservice.

It uses kubernetes healthchecks for availability,
AWS ALB as a high availlable load balancer with automatic generated self-signed TLS certificate

(I decided to just deploy self-signed cert because making real valid cert requires to deploy a domain that will make test this proof of concept more complex, but can be easily done adding terraform route53 aws module.

All the system is 100% automated deployed and destroyed using terraform and helm.

Continuous Integration of helloworld applications happens on github using github actions and pushing a public image on docker hub.

![System design](./docs/diagram.svg)

## Installation

### Prerequisites
1. make
2. terraform v0.13.5 [download](https://releases.hashicorp.com/terraform/0.13.5/)
3. aws cli installed and configured with an account [details](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
4. aws-iam-authenticator installed [details](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
5. kubectl [details](https://kubernetes.io/es/docs/tasks/tools/install-kubectl/)

### Instructions
```
#Check you have all the applications needed installed
make preflight

#login to your AWS account with your access key ID & secret access key.
make login

#initialize infrastructure deployment requirements
make init
```

At this point you can edit  ```variables.tf```
to modify cluster name, number of workers....


```
#Deploy infrastructure
make deploy

#Test Deployment is OK
make test
```
At this point you have the cluster with the application up and running!

Terraform will output your kubeconfig and application URL on ```output``` folder
or just execute

### Destroying all the infrastructure
```
make destroy
```
There is a known bug [#283](https://github.com/terraform-aws-modules/terraform-aws-vpc/issues/283) in aws vpc terraform module that make 
destroy some times fail, so VPC must be removed by hand.

example of the error:
```
Error: Error deleting VPC: DependencyViolation: The vpc 'vpc-xxxxxxxxxxx' has dependencies and cannot be deleted.
        status code: 400, request id: xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx
```


## Production notes
Go to [Production notes](./production.md) for more details about production readiness.