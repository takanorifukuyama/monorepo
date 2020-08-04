terraform {
  backend "gcs" {
    bucket = "blue-terraform"
    prefix  = "blue"
  }
}
