resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    name = "main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway_attachment" "gwa" {
  internet_gateway_id = aws_internet_gateway.gw.id
  vpc_id              = aws_vpc.main.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.20.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "VPC_A_Public_Subnet_A"
  }

}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.10.0/24"
    availability_zone       = "eu-west-1b"
    map_public_ip_on_launch = "false"

    tags = {
        Name = "VPC_A_Private_Subnet_A"
    }
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_routetableAS" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "private_routeAS" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.privatert.id
}