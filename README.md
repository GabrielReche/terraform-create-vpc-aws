# Estrutura do Projeto

main.tf
outputs.tf
variables.tf

## main.tf

Este arquivo Terraform cria uma infraestrutura básica na AWS, incluindo uma Virtual Private Cloud (VPC) com sub-redes públicas e privadas, juntamente com um Internet Gateway para permitir acesso à Internet pelas sub-redes públicas.

Funções principais:

Criação da VPC: Define uma VPC com o bloco CIDR especificado e habilita suporte a DNS e DNS hostnames.

Criação das sub-redes públicas: Cria sub-redes acessíveis diretamente pela Internet, cada uma associada a um bloco CIDR específico e distribuída nas Zonas de Disponibilidade da região AWS.

Criação das sub-redes privadas: Cria sub-redes que não têm acesso direto à Internet, cada uma associada a um bloco CIDR específico e distribuída nas Zonas de Disponibilidade da região AWS.

Configuração do Internet Gateway: Cria um Internet Gateway e o associa à VPC para permitir o tráfego de entrada e saída para as sub-redes públicas.

Configuração do NAT Gateway: Provisiona um NAT Gateway em uma das sub-redes públicas para permitir que instâncias nas sub-redes privadas iniciem conexões de saída para a Internet de forma segura, sem permitir que serviços externos iniciem conexões com essas instâncias.

Configuração das tabelas de roteamento: Define tabelas de roteamento para direcionar o tráfego corretamente entre as sub-redes públicas (com rota para o Internet Gateway) e privadas (com rota para o NAT Gateway, mas sem rota direta para a Internet).

## Informações para mudar em um novo projeto - main.tf

Nome da VPC (aws_vpc.main_vpc): Personalize o nome da VPC conforme a convenção de nomenclatura do seu novo projeto.

Blocos CIDR das sub-redes públicas e privadas (var.public_subnet_cidrs, var.private_subnet_cidrs): Atualize os blocos CIDR das sub-redes de acordo com os requisitos do seu novo ambiente.

Nome do Internet Gateway (var.internet_gateway_name): Ajuste o nome do Internet Gateway conforme necessário para o seu novo projeto.


## outputs.tf

Este arquivo define as saídas do Terraform, que são valores que podem ser utilizados posteriormente.

Funções principais:

Saída do ID da VPC criada (vpc_id): Fornece o ID da VPC criada, permitindo referenciá-la em configurações de outros recursos ou scripts.

Saída dos IDs das sub-redes públicas criadas (public_subnet_ids): Lista os IDs de todas as sub-redes públicas criadas, facilitando a configuração de recursos que precisam estar em sub-redes acessíveis pela Internet.

Saída dos IDs das sub-redes privadas criadas (private_subnet_ids): Lista os IDs de todas as sub-redes privadas criadas, útil para configurar recursos que não precisam de acesso direto à Internet.

Saída do ID do NAT Gateway (nat_gateway_id): Fornece o ID do NAT Gateway criado, permitindo referenciar em configurações de roteamento e políticas de segurança das sub-redes privadas.

## Informações para mudar em um novo projeto - outputs.tf

Nomes das saídas (output blocks): Renomeie as saídas conforme a convenção de nomenclatura do seu novo projeto, se necessário.

Recursos específicos (aws_vpc.main_vpc, aws_subnet.public_subnet, aws_subnet.private_subnet, aws_nat_gateway.main_nat_gateway): Verifique se os recursos referenciados correspondem aos nomes utilizados no arquivo main.tf ou outros arquivos relevantes do seu projeto.

## variables.tf

Este arquivo define as variáveis que serão utilizadas em todo o projeto.

Funções principais:

Variável aws_region: Define a região da AWS onde os recursos serão criados. O valor padrão é us-east-1, mas pode ser alterado para qualquer região suportada pela AWS.

Variável vpc_cidr: Define o bloco CIDR para a VPC (Virtual Private Cloud). O valor padrão é 10.0.0.0/16, mas pode ser ajustado para qualquer bloco CIDR desejado.

Variável vpc_name: Define a tag de nome para a VPC. O valor padrão é "MinhaVPC", mas pode ser alterado para refletir a convenção de nomenclatura utilizada no seu projeto.

Variável public_subnet_cidrs: Define os blocos CIDR para as sub-redes públicas. O valor padrão é uma lista com dois exemplos (["10.0.1.0/24", "10.0.2.0/24"]), mas pode ser expandido ou ajustado conforme necessário para suportar mais sub-redes ou diferentes configurações de rede.

Variável private_subnet_cidrs: Define os blocos CIDR para as sub-redes privadas. O valor padrão é uma lista com dois exemplos (["10.0.11.0/24", "10.0.12.0/24"]), mas pode ser expandido ou ajustado conforme necessário para suportar mais sub-redes ou diferentes configurações de rede.

Variável internet_gateway_name: Define a tag de nome para o Internet Gateway. O valor padrão é "MainGateway", mas pode ser modificado para se adequar à política de nomenclatura adotada pelo seu projeto.

Variável nat_gateway_subnet_id: Define a subnet onde será criado o NAT Gateway. O valor padrão é null, indicando que o NAT Gateway não será criado por padrão.

## Informações para mudar em um novo projeto - variables.tf

Descrições (description): Atualize as descrições das variáveis conforme necessário para melhorar a compreensão das configurações do projeto.

Valores padrão (default): Ajuste os valores padrão das variáveis de acordo com os requisitos específicos do novo projeto. Isso pode incluir diferentes regiões da AWS, blocos CIDR personalizados, ou nomes específicos para recursos como a VPC e sub-redes.



# Passos para Executar o Projeto na AWS:

1. Configuração Inicial:

Certifique-se de ter o Terraform instalado em sua máquina local.
Configure suas credenciais AWS localmente utilizando aws configure para autenticar o Terraform com a AWS.

2. Clone o Repositório:

Clone o repositório Git onde seus arquivos do Terraform estão armazenados localmente.

3. Inicialize o Diretório do Terraform:

Abra o terminal, navegue até o diretório onde estão seus arquivos do Terraform (main.tf, variables.tf, etc.).
Execute o comando terraform init para inicializar o diretório do Terraform. Isso baixará os plugins necessários e configurará seu ambiente.

4. Visualize as Mudanças Propostas (Opcional):

Execute terraform plan para ver uma prévia das alterações que o Terraform fará na sua infraestrutura AWS. Isso é útil para verificar se há erros ou configurações que precisam ser ajustadas.

5. Aplicar as Mudanças:

Execute terraform apply para aplicar as alterações definidas nos arquivos do Terraform à sua conta AWS. O Terraform solicitará sua confirmação antes de fazer qualquer alteração.

6. Aprovação do Plano:

Durante o terraform apply, o Terraform mostrará um resumo das mudanças planejadas. Digite yes quando solicitado para aplicar as mudanças.

7. Acompanhe o Progresso:

O Terraform começará a criar os recursos especificados (VPC, EKS cluster, etc.). Isso pode levar algum tempo, dependendo da complexidade do ambiente definido.

8. Verifique a Implantação:

Após a conclusão, o Terraform exibirá uma mensagem indicando que os recursos foram criados com sucesso.
Verifique no console da AWS se os recursos foram criados conforme esperado.

9. Gerenciar os Recursos:

Para gerenciar seus recursos no futuro (atualizações, destruição, etc.), use comandos Terraform como terraform apply, terraform destroy, etc., conforme necessário.


10. Observações Importantes:

Gerenciamento de Estado: O Terraform mantém um estado do ambiente implantado localmente. Certifique-se de guardar e gerenciar este estado de forma segura para evitar perda de dados ou alterações não autorizadas.

Segurança: Mantenha suas credenciais AWS seguras e evite compartilhá-las publicamente.

Monitoramento: Após a implantação, monitore seus recursos na AWS para garantir que tudo esteja funcionando conforme esperado e que não haja custos inesperados.
