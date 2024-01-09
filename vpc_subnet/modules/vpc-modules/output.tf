output "project-name" {
    value = var.project-name
}

output "vpc_id" {
    value = aws_vpc.main-vpc.id
}

output "subnet_id-A" {
    value = aws_subnet.subnet-A.id
}

output "subnet_id-B" {
    value = aws_subnet.subnet-B.id
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}
