# Saída do ID da VPC criada
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

# Saída dos IDs das sub-redes públicas criadas
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

# Saída dos IDs das sub-redes privadas criadas
output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}
