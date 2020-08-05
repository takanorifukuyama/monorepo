# terraform difined file

## initialization

- magage production environment and development environment with terraform workspace feature.
- In order to avoid executing Terraform in the development or production environment by mistake, execute one of the following commands instead of executing the Terraform command directly.

`./terraform-prod.sh`
`./terraform-dev.sh`


## process

- You have to put gcp service account credentials in terraform root directory. And rename the credential file `gcp_sa_credencial.json`.

