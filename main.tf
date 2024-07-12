# Definição do provider AWS
provider "aws" {
  region = var.aws_region
}

# Criação da VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Criação das sub-redes públicas
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}

# Criação das sub-redes privadas
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "Private_Subnet_${count.index + 1}"
  }
}

# Criação do Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

# Associação do Internet Gateway à VPC
resource "aws_vpc_attachment" "igw_attachment" {
  vpc_id             = aws_vpc.main_vpc.id
  internet_gateway_id = aws_internet_gateway.main_igw.id
}

# Criação do NAT Gateway
resource "aws_nat_gateway" "main_nat_gateway" {
  allocation_id = aws_eip.main_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id  # Escolha a primeira sub-rede pública para o NAT Gateway

  tags = {
    Name = "MainNatGateway"
  }
}

# Alocação de um Elastic IP para o NAT Gateway
resource "aws_eip" "main_eip" {
  vpc = true
}

# Criação da tabela de rotas para sub-redes privadas (não terá rota para internet)
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "PrivateRouteTable"
  }
}

# Associação das sub-redes privadas à tabela de rotas privadas
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# Rota para o NAT Gateway na tabela de roteamento privada
resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.main_nat_gateway.id
}
