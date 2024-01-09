resource "aws_vpc" "main-vpc" {
    cidr_block       = var.cidr_block
    instance_tenancy = "default"

    tags = {
        Name = "${var.project-name}-vpc"
    }
}

data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_subnet" "subnet-A" {
    vpc_id     = aws_vpc.main-vpc.id
    cidr_block = var.subnet-A-cidr_block
    map_public_ip_on_launch = "true"
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        Name = "${var.project-name}-subnet"
    }
}

resource "aws_subnet" "subnet-B" {
    vpc_id     = aws_vpc.main-vpc.id
    cidr_block = var.subnet-B-cidr_block
    map_public_ip_on_launch = "false"
    availability_zone = data.aws_availability_zones.available.names[1]

    tags = {
        Name = "${var.project-name}-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main-vpc.id

    tags = {
        Name = "${var.project-name}-igw"
    }
}

resource "aws_route_table" "root-a" {
    vpc_id = aws_vpc.main-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.project-name}-route-table-A"
    }
}

resource "aws_route_table_association" "root-ass-A" {
    subnet_id      = aws_subnet.subnet-A.id
    route_table_id = aws_route_table.root-a.id
}

resource "aws_eip" "lb" {
    domain   = "vpc"

    tags = {
        Name = "${var.project-name}-eip"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.lb.id
    subnet_id     = aws_subnet.subnet-A.id

    tags = {
        Name = "${var.project-name}-nat-g"
    }

    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "root-b" {
    vpc_id = aws_vpc.main-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
        Name = "${var.project-name}-route-table-B"
    }
}

resource "aws_route_table_association" "root-ass-B" {
    subnet_id      = aws_subnet.subnet-B.id
    route_table_id = aws_route_table.root-b.id
}