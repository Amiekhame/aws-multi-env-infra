terraform {
    backend "s3" {
        bucket = "oshomybuckett"
        key    = "prod-env/terraform.tfstate"
        region = "eu-central-1"
        profile = "default"
    }
}

