resource "aws_vpc" "tf_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  count                   = length(var.subnet_cidr_block)
  cidr_block              = var.subnet_cidr_block[count.index]
  availability_zone       = var.region_zone[count.index % length(var.region_zone)]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "tf_public_subnet_${count.index + 1}"
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id
}

resource "aws_route_table" "tf_public_route_table" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "tf_public_route_table"
  }
}

resource "aws_route_table_association" "tf-public_route_table_association_subnet" {
  route_table_id = aws_route_table.tf_public_route_table.id
  count          = length(var.subnet_cidr_block)
  subnet_id      = aws_subnet.tf_public_subnet[count.index].id
}
