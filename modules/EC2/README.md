### Módulo EC2

Este módulo de Terraform aprovisiona los siguientes recursos de AWS para configurar instancias EC2, grupos de seguridad y balanceo de carga dentro de un entorno VPC.

## Recursos Creado

### 1. Instancias EC2
- **Instancia Windows** (`aws_instance.Windows`): Aprovisiona una instancia EC2 de Windows con las siguientes características:
  - El AMI, tipo de instancia y nombre de la clave están parametrizados.
  - El grupo de seguridad permite tráfico entrante RDP (Remote Desktop Protocol) en el puerto 3389 desde el bloque CIDR `10.0.0.0/8`.
  - El disco raíz es de tipo `gp3` con un tamaño de 30 GB.
  - La instancia tiene las etiquetas `Name: Windows` y `PatchManager: Testing`.

- **Instancia Ubuntu** (`aws_instance.Ubuntu`): Aprovisiona una instancia EC2 de Ubuntu con:
  - AMI, tipo de instancia y nombre de la clave parametrizados.
  - El grupo de seguridad permite tráfico HTTP entrante en el puerto 80 desde cualquier origen.
  - El disco raíz es de tipo `gp3` con un tamaño de 8 GB, etiquetado como `${local.instance_name}-EBS`.
  - Incluye un script de datos de usuario (user data) desde un archivo para configurar el cliente Redis.
  - Etiquetas `Name: Ubuntu` y `PatchManager: Testing`.

- **Instancia AWS Linux** (`aws_instance.AWS`): Aprovisiona una instancia EC2 con AWS Linux con:
  - AMI, tipo de instancia y nombre de la clave parametrizados.
  - El grupo de seguridad permite tráfico SSH entrante en el puerto 22 desde el bloque CIDR `10.0.0.0/8`.
  - Etiquetas `Name: AWS` y `PatchManager: Testing`.

### 2. Grupos de Seguridad
- **SG-Windows**: Permite tráfico RDP en el puerto 3389 para instancias Windows desde el rango CIDR `10.0.0.0/8`.
- **SG-Linux**: Permite tráfico HTTP en el puerto 80 para instancias Ubuntu desde cualquier dirección IP.
- **SG-AWS**: Permite tráfico SSH en el puerto 22 para instancias AWS desde el rango CIDR `10.0.0.0/8`.
- **SG-Redis**: Permite tráfico Redis en el puerto 6379 desde el bloque CIDR `172.16.0.0/16`.

### 3. Balanceador de Carga
- **Balanceador de Carga de Red (NLB)** (`aws_lb.NLB-AVA`): Aprovisiona un NLB interno con subnets en las subnets privadas A y B. Reenvía tráfico en el puerto 80 a la instancia Ubuntu.
- **Grupo de Destinos** (`aws_lb_target_group.TG-NGINX`): Crea un grupo de destino para que la instancia Ubuntu reciba tráfico en el puerto 80 utilizando el protocolo TCP.
- **Adjunto del Grupo de Destinos** (`aws_lb_target_group_attachment.TG-Attachment`): Adjunta la instancia Ubuntu al grupo de destino.
- **Listener del NLB** (`aws_lb_listener.LISTENER-NGINX`): Configura el NLB para escuchar en el puerto 80 y reenviar el tráfico al grupo de destino NGINX.

## Entradas
- `ec2_windows_specs`: Detalles de configuración para la instancia EC2 de Windows, incluidos el AMI y el tipo de instancia.
- `ec2_linux_specs`: Detalles de configuración para la instancia EC2 de Ubuntu.
- `ec2_aws_specs`: Detalles de configuración para la instancia EC2 con AWS Linux.
- `private_subnet_a_id`: El ID de la subnet privada A.
- `private_subnet_b_id`: El ID de la subnet privada B.
- `vpc_id`: El ID de la VPC a la que pertenecen las instancias y los grupos de seguridad.
- `natgw_id`: Dependencia del NAT Gateway para las instancias Ubuntu y AWS.

## Salidas
- **ID de la Instancia Ubuntu**: Se genera la salida del ID de la instancia EC2 de Ubuntu.

## Notas
- Las instancias están asociadas al perfil de IAM `SSM`, lo que habilita el acceso a través de System Manager.
- Los grupos de seguridad definen el tráfico permitido entrante y saliente.
- La configuración del cliente Redis se despliega en la instancia Ubuntu utilizando un script de datos de usuario (user data).
