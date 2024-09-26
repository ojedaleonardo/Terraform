### VPC (Virtual Private Cloud)

# Despliegue de Infraestructura en AWS usando Terraform

Este repositorio contiene el código de Terraform que configura una infraestructura de red básica en AWS, incluyendo una VPC, subnets públicas y privadas, tablas de ruteo, un NAT Gateway y un Internet Gateway.

## Recursos

### 1. **VPC (Virtual Private Cloud)**
   - **Recurso**: `aws_vpc`
   - **Nombre**: `Test-VPC`
   - **Descripción**: Se crea una VPC con el bloque CIDR definido por la variable `var.vpc_cidr` y un tag `Name` definido por `var.vpc_name`.
   - **Variables**:
     - `vpc_cidr`: Bloque CIDR de la VPC.
     - `vpc_name`: Nombre de la VPC.

### 2. **Subnets Privadas**
   - **Recurso**: `aws_subnet`
   - Se crean dos subnets privadas en diferentes zonas de disponibilidad.

   - **Private-A**:
     - **Zona de disponibilidad**: `us-east-1a`.
     - **CIDR**: Definido por `var.private_a_cidr`.
     - **VPC asociada**: `aws_vpc.Test-VPC`.

   - **Private-B**:
     - **Zona de disponibilidad**: `us-east-1b`.
     - **CIDR**: Definido por `var.private_b_cidr`.
     - **VPC asociada**: `aws_vpc.Test-VPC`.

### 3. **Subnets Públicas**
   - **Recurso**: `aws_subnet`
   - Se crean dos subnets públicas en diferentes zonas de disponibilidad.

   - **Public-A**:
     - **Zona de disponibilidad**: `us-east-1a`.
     - **CIDR**: Definido por `var.public_a_cidr`.
     - **VPC asociada**: `aws_vpc.Test-VPC`.

   - **Public-B**:
     - **Zona de disponibilidad**: `us-east-1b`.
     - **CIDR**: Definido por `var.public_b_cidr`.
     - **VPC asociada**: `aws_vpc.Test-VPC`.

### 4. **Tablas de Ruteo**
   - **Recurso**: `aws_route_table`
   - Se crean dos tablas de ruteo, una para las subnets públicas y otra para las subnets privadas.

   - **Private Route Table**: 
     - **Nombre**: `${var.vpc_name}-Private-rtb`.
     - **VPC asociada**: `aws_vpc.Test-VPC`.
     - **Ruta predeterminada**: Ruta a `0.0.0.0/0` a través del NAT Gateway.

   - **Public Route Table**:
     - **Nombre**: `${var.vpc_name}-Public-rtb`.
     - **VPC asociada**: `aws_vpc.Test-VPC`.
     - **Ruta predeterminada**: Ruta a `0.0.0.0/0` a través del Internet Gateway.

### 5. **Asociaciones de Tablas de Ruteo**
   - **Recurso**: `aws_route_table_association`
   - Se asocian las subnets a sus respectivas tablas de ruteo.

   - **Asociaciones privadas**:
     - `Private-A`: Asociada a la tabla de ruteo privada.
     - `Private-B`: Asociada a la tabla de ruteo privada.

   - **Asociaciones públicas**:
     - `Public-A`: Asociada a la tabla de ruteo pública.
     - `Public-B`: Asociada a la tabla de ruteo pública.

### 6. **Internet Gateway**
   - **Recurso**: `aws_internet_gateway`
   - **Nombre**: `${var.vpc_name}-IGW`.
   - **Descripción**: Se despliega un Internet Gateway para permitir que las subnets públicas tengan acceso a Internet.
   - **VPC asociada**: `aws_vpc.Test-VPC`.

### 7. **NAT Gateway**
   - **Recurso**: `aws_nat_gateway`
   - **Nombre**: `${var.vpc_name}-NATGW`.
   - **Descripción**: Proporciona acceso a Internet para las instancias en las subnets privadas.
   - **Subnets asociadas**: Se despliega en la subnet pública `Public-A`.
   - **EIP (Elastic IP)**: Se utiliza una Elastic IP para el NAT Gateway.

### 8. **Elastic IP (EIP)**
   - **Recurso**: `aws_eip`
   - **Nombre**: `${var.vpc_name}-EIP`.
   - **Descripción**: Elastic IP asociada al NAT Gateway para permitir acceso público desde las subnets privadas a través del NAT Gateway.
   - **Dominio**: `vpc`.

### 9. **Rutas**
   - **Recurso**: `aws_route`
   - Se configuran rutas predeterminadas (`0.0.0.0/0`) para el tráfico de las subnets.

   - **Rutas privadas**:
     - El tráfico de las subnets privadas pasa por el NAT Gateway.

   - **Rutas públicas**:
     - El tráfico de las subnets públicas pasa por el Internet Gateway.

### 10. **Subnet Group Elasticache Redis**
 - **Recurso**: `aws_elasticache_subnet_group`
- **Nombre**: `Private-Redis`
- **Descripción**: Este recurso crea un grupo de subnets específico para usar con Amazon ElastiCache. El grupo de subnets permite que ElastiCache despliegue instancias en las subnets privadas dentro de la VPC.
- **Subnets asociadas**: El grupo incluye las subnets privadas Private-A y Private-B, proporcionando redundancia y alta disponibilidad en dos zonas de disponibilidad diferentes (us-east-1a y us-east-1b).

## Estructura del Código

El código está organizado en módulos para facilitar la reutilización y mantener una estructura limpia y escalable. Cada servicio de AWS se encuentra en su propio módulo.

