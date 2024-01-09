resource "aws_security_group" "sg-1" {
    description = "Allow ssh conection on port 22, allow http on port 80, allow https on port 443"
    vpc_id      = var.vpc_id

    ingress {
        description = "Allow ssh conection on port 22"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow http conection on port 80"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow https conection on port 443"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project-name}-sg-1"
    }
}

resource "aws_security_group" "sg-2" {
    description = "Allow ssh conection from public subnet on port 22 and icmp from public subnet"
    vpc_id      = var.vpc_id

    ingress {
        description = "Allow ssh conection from public subnet on port 22"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        security_groups = [aws_security_group.sg-1.id]
    }

    ingress {
        description = "Allow icmp from public subnet"
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        security_groups = [aws_security_group.sg-1.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project-name}-sg-2"
    }
}