terraform {
  backend "gcs" {
    bucket = "blue-terraform_20200805"
    prefix  = "blue"
  }
}
