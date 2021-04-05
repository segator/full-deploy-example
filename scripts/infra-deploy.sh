#!/bin/sh
mkdir output
set -e

echo "applying infrastructure"
terraform apply -auto-approve

terraform output application_endpoint > output/application_endpoint
terraform output k8s_kubeconfig > output/kubeconfig