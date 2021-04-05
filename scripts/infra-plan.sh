#!/bin/sh
set -e

echo "preparing infrastructure"
terraform init
terraform plan