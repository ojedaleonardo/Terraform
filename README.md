# Infraestructura en AWS

Este repositorio contiene el código de Terraform modulado por servicios de AWS para desplegar una infraestructura básica en la región de Virginia (us-east-1).

## Descripción de modulos:

- [VPC](./modules/VPC/README.md): Despliega la red VPC, subnets, tablas de ruteo y gateways, configura el NAT Gateway y la Elastic IP Asociada. Configura el grupo de Subnets privadas para ElastiCache.

- [EC2](./modules/EC2/README.md): Despliega un entorno de instancias EC2 en AWS, incluyendo una instancia de Windows, una instancia de Ubuntu y una instancia con AWS Linux. También configura los grupos de seguridad necesarios para controlar el tráfico de red y un balanceador de carga de red (NLB) para gestionar el tráfico hacia la instancia de Ubuntu. Adicionalmente, se implementan scripts de configuración para el cliente Redis en la instancia Ubuntu. Este enfoque permite una infraestructura escalable y segura, optimizada para la conectividad y el acceso.

## Estructura del Código

El código está organizado en módulos para facilitar la reutilización y mantener una estructura limpia y escalable. Cada servicio de AWS se encuentra en su propio módulo.

## Requisitos

- Terraform >= 1.0.0
- Proveedor de AWS
- Una cuenta de AWS activa.

## Uso

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/tu-repositorio.git
