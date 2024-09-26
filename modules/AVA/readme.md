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

Este módulo es fundamental para integrar el control de acceso basado en identidades en aplicaciones que requieren autenticación de usuarios, proporcionando una solución robusta y segura para la gestión de identidades en la nube.

***en proceso***

