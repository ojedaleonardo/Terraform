### Módulo Cognito

Este módulo despliega un servicio de autenticación y gestión de usuarios utilizando Amazon Cognito, el cual incluye:

- **User Pool**: Se crea un grupo de usuarios llamado "MyCognitoUserPool" que permite la autenticación de usuarios a través de su correo electrónico. Se establece una política de contraseñas que requiere un mínimo de 8 caracteres. Además, se configura la recuperación de cuentas mediante el correo electrónico verificado.

- **Cliente de User Pool**: Se define un cliente para la aplicación llamado "MyAppClient", el cual habilita varios flujos de autenticación y permite la integración con OAuth2. Este cliente se utiliza para autenticar a los usuarios y obtener tokens de acceso.

- **Dominio del User Pool**: Se establece un dominio para el grupo de usuarios, lo que permite acceder a las funciones de autenticación a través de URLs personalizadas.

- **Usuarios**: Se crean dos usuarios en el grupo de usuarios. El usuario "leonardo@tutosleo.online" tiene la dirección de correo verificada y se le proporciona una contraseña temporal. El usuario "ariel@tutosleo.online" se crea sin la verificación del correo electrónico.

Este módulo proporciona una solución segura y escalable para la gestión de usuarios y la autenticación en aplicaciones web y móviles.
