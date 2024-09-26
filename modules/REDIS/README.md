### Módulo REDIS

Este módulo de Terraform aprovisiona un clúster de Redis utilizando Amazon ElastiCache, configurando un grupo de replicación para alta disponibilidad y seguridad.

## Recursos Creado

### 1. Clúster de Redis
- **Grupo de Replicación Redis** (`aws_elasticache_replication_group.Redis`): Configura un clúster de Redis con las siguientes características:
  - **ID del Grupo de Replicación**: `Redis`.
  - **Tipo de Nodo**: `cache.t2.micro`, adecuado para entornos de desarrollo y pruebas.
  - **Alta Disponibilidad**: Habilita la conmutación por error automática y la configuración multi-AZ para resiliencia.
  - **Seguridad**: 
    - Habilita la encriptación en tránsito y en reposo para proteger los datos.
    - Utiliza un token de autenticación (`auth_token`) para mayor seguridad.
  - **Grupos de Subredes**: Se especifica un grupo de subredes para el despliegue del clúster.
  - **Descripción**: `Cluster de Redis`.
  - **Puerto**: Expone el puerto `6379`, el puerto estándar para Redis.
  - **Grupo de Parámetros**: Utiliza el grupo de parámetros predeterminado para Redis en modo clúster (`default.redis7.cluster.on`).
  - **Número de Grupos de Nodos**: Configura dos grupos de nodos, cada uno con un replica.

## Entradas
- `redis_security_group_id`: El ID del grupo de seguridad que permite el tráfico hacia el clúster de Redis.
- `redis_subnet_group_id`: El ID del grupo de subredes donde se despliega el clúster de Redis.

## Descripción del Despliegue

Este módulo despliega un clúster de Redis en AWS, configurando un grupo de replicación con alta disponibilidad y encriptación. Está diseñado para manejar tráfico seguro y proporciona capacidades de conmutación por error. Utiliza instancias de tipo `cache.t2.micro`, lo que lo hace adecuado para entornos de desarrollo y pruebas, mientras que las características de seguridad aseguran que los datos estén protegidos tanto en tránsito como en reposo.
