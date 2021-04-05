#!/bin/sh

echo "Kubernetes Nodes"
kubectl --kubeconfig=./output/kubeconfig get nodes

echo "Kubernetes pods"
kubectl --kubeconfig=./output/kubeconfig get pods -n application

echo "Kubernetes ingress"
kubectl --kubeconfig=./output/kubeconfig get ingress -n application

echo "Kubernetes helloworld app running"
url_app_under_test="https://$(cat ./output/application_endpoint)/helloworld"
for i in {1..10}
do
 echo "Test loop $i on $url_app_under_test"
 curl --insecure $url_app_under_test
 echo ""
 sleep 1
done
