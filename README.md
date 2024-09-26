# Proyecto de Terraform - Infraestructura en AWS

Este repositorio contiene el código de Terraform modulado por servicios de AWS para desplegar una infraestructura básica en la región de Virginia (us-east-1).

## Descripción

El siguiente código crea una infraestructura con los siguientes componentes:

### VPC (Virtual Private Cloud)

- **CIDR**: 172.16.0.0/16
- **Subnets**: 
  - 2 subnets públicas.
  - 2 subnets privadas.
  - Las subnets están distribuidas en las zonas de disponibilidad A y B de la región us-east-1 (Virginia).
  - 2 route tables (1 para las Subnets Privates y 1 para las Subnets Publics)
- **NAT Gateway**: Se despliega un NAT Gateway para permitir que las subnets privadas tengan acceso a Internet para actualizaciones o descargas de software, sin exponer las instancias directamente.
- **Internet Gateway**: Se despliega un Internet Gateway para permitir que las subnets públicas puedan comunicarse con el exterior.

## Estructura del Código

El código está organizado en módulos para facilitar la reutilización y mantener una estructura limpia y escalable. Cada servicio de AWS se encuentra en su propio módulo.

## Requisitos

- Terraform >= 1.0.0
- AWS CLI configurado con las credenciales necesarias.
- Una cuenta de AWS activa.

## Uso

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/tu-repositorio.git
