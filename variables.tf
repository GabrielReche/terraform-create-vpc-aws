variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  default     = "MinhaVPC"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Exemplo de duas sub-redes públicas
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]  # Exemplo de duas sub-redes privadas
}

variable "internet_gateway_name" {
  description = "Name tag for the Internet Gateway"
  default     = "MainGateway"
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]  # Defina suas zonas de disponibilidade aqui
}
