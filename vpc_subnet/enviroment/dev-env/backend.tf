terraform {
    backend "s3" {
        bucket = "oshomybuckett"
        key    = "dev-env/terraform.tfstate"
        region = "eu-central-1"
        profile = "default"
    }
}

