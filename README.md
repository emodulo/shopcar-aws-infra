# shopcar-aws-infra

O repositório `shopcar-aws-infra` é responsável pelo provisionamento completo da infraestrutura em nuvem na AWS para a plataforma ShopCar. Ele utiliza **Terraform** como ferramenta de infraestrutura como código (IaC) e adota as melhores práticas de modularização, segurança e reutilização.

## O que este repositório provisiona?

- VPC e sub-redes privadas/públicas
- Cluster **EKS (Elastic Kubernetes Service)**
- Grupos de segurança e roles do IAM
- Buckets S3 para armazenamento (incluindo remote state do Terraform)
- Load Balancer Controller (ALB Controller)
- Autenticação com `aws_eks_cluster_auth` para o `provider kubernetes`
- Integração com GitHub Actions para CI/CD

## Estrutura do Projeto

```
shopcar-aws-infra/
├── .github/
│   └── workflows/
│       ├── deploy.yaml
│       └── destroy.yaml
├── vpc/
│   ├── dev/
│   ├── prd/
├── eks/
│   ├── dev/
│   └── prd/
├── cognito/
│   ├── dev/
│   └── prd/
```

## Como aplicar a infraestrutura

> Pré-requisitos:
> - AWS CLI configurado
> - Terraform >= 1.3
> - Permissões de administrador ou via role de CI/CD

```bash
cd environments/prd
terraform init
terraform apply
```

> Para destruir a infraestrutura:

```bash
terraform destroy
```

## Remote State

O estado remoto é armazenado em um bucket S3 seguro.

## Segurança

- As roles e políticas são criadas com princípio do menor privilégio
- Uso de `secrets manager` ou `IRSA` pode ser adicionado conforme necessidade
- Comunicação interna via VPC privada entre serviços

## Integração com CI/CD

Repositórios de aplicação (`ms-*`, `shopcar-infra`) utilizam este repositório para garantir que o cluster esteja disponível e atualizado, usando GitHub Actions.

---

## Contribuidores

- Kreverson Silva – Arquiteto e Engenheiro de Infraestrutura