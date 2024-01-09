provider "aws" {
    region   = var.region
    profile  = "default"
}

module "vpc-modules" {
    source = "../../modules/vpc-modules"
    project-name = var.project-name
    cidr_block = var.cidr_block
    subnet-A-cidr_block = var.subnet-A-cidr
    subnet-B-cidr_block = var.subnet-B-cidr
}

module "security-modules" {
    source = "../../modules/security-modules"
    vpc_id = module.vpc-modules.vpc_id
    project-name = var.project-name
}

module "instance-modules" {
    source = "../../modules/instance-modules"
    project-name = var.project-name
    region = var.region
    env = var.env
    instance_type = var.instance_type
    sg-1_id = module.security-modules.sg-1_id
    sg-2_id = module.security-modules.sg-2_id
    subnet_id-A = module.vpc-modules.subnet_id-A
    subnet_id-B = module.vpc-modules.subnet_id-B
}