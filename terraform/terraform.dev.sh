#!/usr/bin/env bash

GOOGLE_BACKEND_CREDENTIALS="./gcp_sa_credencial.json"
COMMAND=$1
OPTION=$2

if [ $COMMAND != init ]; then
  TFENV=dev
  terraform workspace select $TFENV
fi

case $COMMAND in
"init") terraform init ;;
"plan") terraform plan -var-file="environments/${TFENV}.tfvars.json" ;;
"apply") terraform apply -var-file="environments/${TFENV}.tfvars.json" ;;
"apply-target") terraform apply -var-file="environments/${TFENV}.tfvars.json"  -target "${OPTION}";;
"destroy") terraform destroy -var-file="environments/${TFENV}.tfvars.json" ;;
"destroy-target") terraform destroy -var-file="environments/${TFENV}.tfvars.json" -target "${OPTION}" ;;
*)
  echo "error: invalid arg"
  exit 1
  ;;
esac

