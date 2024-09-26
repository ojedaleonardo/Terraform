### Módulo AVA

Este módulo despliega la infraestructura necesaria para la autenticación y autorización de usuarios mediante Amazon Verified Access y Amazon Cognito. A continuación se detallan los principales recursos que se crean:

- **Proveedor de Confianza (Trust Provider)**: Se establece un proveedor de confianza de tipo usuario que utiliza OpenID Connect (OIDC) para la autenticación. Este recurso permite que las aplicaciones validen y gestionen identidades de usuarios de manera segura a través de Amazon Cognito.

- **Configuración de OIDC**: 
  - **Issuer**: Se especifica la URL del grupo de usuarios de Cognito que actúa como el emisor del token.
  - **Endpoints**:
    - **Authorization Endpoint**: URL que los usuarios utilizan para iniciar sesión y obtener un código de autorización.
    - **Token Endpoint**: URL para intercambiar el código de autorización por un token de acceso.
    - **User Info Endpoint**: URL que se utiliza para obtener información del usuario autenticado.
  - **Client ID y Client Secret**: Se configuran las credenciales necesarias para la autenticación del cliente en el proceso OIDC.

- **Scopes**: Se definen los ámbitos (scopes) de acceso que la aplicación solicitará, permitiendo a los usuarios compartir información específica de su perfil, como el correo electrónico y la información básica del usuario.

- **Instancia de Verified Access**: 
  - Se crea una instancia de Verified Access que se utilizará para gestionar las conexiones y el acceso de los usuarios a los recursos. Esta instancia actúa como un punto de control que autentica a los usuarios antes de permitirles acceder a las aplicaciones o recursos protegidos.
  - **Descripción**: Se proporciona una descripción para la instancia, que ayuda a identificar su propósito dentro de la infraestructura.
  - **Relación con el Proveedor de Confianza**: La instancia de Verified Access se configura para utilizar el proveedor de confianza de Cognito, asegurando que la autenticación se gestione de forma centralizada y segura.

- **Grupo de Verified Access**:
  - Se crea un grupo de Verified Access que permite la gestión y organización de las instancias de Verified Access. Este grupo es fundamental para controlar el acceso a los recursos y para facilitar la asignación de políticas y permisos a las instancias.
  - **Descripción**: El grupo se identifica con una descripción clara, como "Grupo de Verified Access para Cognito", lo que facilita su administración y uso.
  - **Relación con la Instancia**: El grupo se adjunta a la instancia de Verified Access, lo que permite que las políticas aplicadas al grupo se hereden y se apliquen a la instancia, fortaleciendo así la seguridad y el control de acceso.

- **Endpoint de Verified Access**:
  - Se crea un endpoint de Verified Access que permite a los usuarios autenticarse y acceder a los recursos protegidos de manera segura.
  - **Descripción**: Este endpoint actúa como punto de entrada para las solicitudes de acceso de los usuarios, validando su identidad a través del proveedor de confianza antes de permitir el acceso.

- **Registro en Route 53**:
  - Se configura un registro en Route 53 para el endpoint de Verified Access, asegurando que el acceso al endpoint sea fácil y accesible a través de un nombre de dominio.
  - **Descripción**: Esto facilita la gestión de DNS y mejora la experiencia del usuario al acceder a las aplicaciones protegidas.

Este módulo es fundamental para integrar el control de acceso basado en identidades en aplicaciones que requieren autenticación de usuarios, proporcionando una solución robusta y segura para la gestión de identidades en la nube.

