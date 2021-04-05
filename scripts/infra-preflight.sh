#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
check_installed() {
    IS_INSTALLED=$(whereis $1 | awk '{print $2}')
    if [ -z "$IS_INSTALLED" ]
    then
        echo -e "$1: ${RED}NOT installed${NC}"
    else
        echo -e "$1: ${GREEN}installed${NC}"
    fi
}

check_installed "aws"
check_installed "aws-iam-authenticator"
check_installed "kubectl"
check_installed "terraform"