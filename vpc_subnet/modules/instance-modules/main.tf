data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

}

resource "tls_private_key" "rsa-key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "key-pair" {
    key_name = "${var.project-name}-key"
    public_key = tls_private_key.rsa-key.public_key_openssh 
}

resource "local_file" "private_key" {
    content = tls_private_key.rsa-key.private_key_pem
    filename = "${var.project-name}-key.pem"
}

resource "aws_instance" "public-instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.key-pair.key_name
    subnet_id = var.subnet_id-A
    vpc_security_group_ids = [var.sg-1_id]
    user_data = file("${path.module}/userdata.sh")
    tags = {
        env   = var.env
        Name = "${var.project-name}-public-instance"
    }
}

resource "aws_instance" "private-instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.key-pair.key_name
    subnet_id = var.subnet_id-B
    vpc_security_group_ids = [var.sg-2_id]
    user_data = file("${path.module}/userdata.sh")
    tags = {
        env   = var.env
        Name = "${var.project-name}-private-instance"
    }
}



