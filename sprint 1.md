Plan de Ejecución del Sprint 1: El Núcleo de Trazabilidad (MVP)
Este documento detalla el trabajo seleccionado del Product Backlog para ser ejecutado en el Sprint 1. El equipo se enfocará en construir el esqueleto funcional de la aplicación, entregando un incremento de valor tangible y demostrable al final del ciclo.
Instrucciones Generales y Documentación de Referencia:
Todo el equipo debe consultar el "Plano Maestro del Proyecto" (nuestro Product Backlog y Canvas Maestro) para mantener el contexto general de la visión del producto. Las decisiones de diseño y arquitectura deben estar alineadas con el Documento de Diseño de Arquitectura (DDA) previamente definido.
Meta del Sprint (Sprint Goal): 🎯
Entregar el esqueleto funcional de la aplicación (MVP) que permita a un Operador de Laboratorio autenticarse, registrar un nuevo activo con su QR, y completar el ciclo de vida completo de un préstamo (prestar y devolver), estableciendo la base de la trazabilidad.
Información del Sprint: | Atributo | Valor | | :--- | :--- | | Sprint | 1 de ~5 | | Duración | 2 Semanas | | Puntos de Historia Totales | 25 Puntos |

Definición de "Hecho" (Definition of Done - DoD)
Para que una historia se considere "Hecha", debe cumplir con TODOS los siguientes criterios:
[ ] El código ha sido revisado y aprobado por al menos un otro miembro del equipo (Peer Review).
[ ] Todos los Criterios de Aceptación han sido cumplidos y validados.
[ ] Se han creado y pasan las pruebas unitarias relevantes para la lógica de negocio.
[ ] El pipeline de Integración Continua (CI) se ejecuta exitosamente con el nuevo código.
[ ] La funcionalidad ha sido probada en los entornos de desarrollo de iOS y Android.
[ ] La funcionalidad ha sido validada mediante pruebas en al menos un dispositivo físico (iOS o Android).
[ ] No se han introducido nuevos bugs críticos o bloqueantes.
[ ] La funcionalidad ha sido demostrada al Product Owner en la Sprint Review.

Sprint Backlog y Desglose de Tareas
ID: VSTLAB-HT-001 (Historia Técnica) - 5 Puntos
Historia: Como equipo de desarrollo, necesitamos configurar el proyecto en Supabase para establecer la base de datos, la autenticación y las APIs que servirán como el backend central del sistema. Criterios de Aceptación:
El esquema inicial de la base de datos (Assets, Branches, Users, Loans) está definido con sus relaciones.
Los roles (Operator, Supervisor, Admin) están definidos con políticas de seguridad de tablas (RLS).
La API RESTful autogenerada está activa y accesible. Tareas Técnicas:
[ ] Backend: Definir y crear las tablas Users, Branches, Assets y Loans en Supabase Studio.
[ ] Backend: Establecer las relaciones de clave foránea entre las tablas (ej: Assets.branch_id -> Branches.id).
[ ] Backend: Configurar el proveedor de autenticación por Email/Contraseña.
[ ] Backend: Escribir las políticas de seguridad básicas de RLS (ej: los usuarios solo pueden ver los activos de su propia sucursal).
[ ] Documentación: Documentar las URLs de la API y las claves de acceso en el repositorio del proyecto.
ID: VSTLAB-HU-001 (Historia de Usuario) - 3 Puntos
Historia: Como nuevo usuario, quiero poder iniciar sesión en la aplicación con mi correo y contraseña para acceder a las funcionalidades que corresponden a mi rol. Criterios de Aceptación:
Se muestran campos para "Correo Electrónico", "Contraseña" y un botón "Ingresar".
Con credenciales válidas, el usuario es redirigido al Dashboard.
Con credenciales incorrectas, se muestra un mensaje de error específico. Tareas Técnicas:
[ ] Frontend: Diseñar y construir la pantalla de Login en Flutter con los campos y botones requeridos.
[ ] Frontend: Implementar la gestión de estado (Riverpod) para el formulario (loading, error, data).
[ ] Integración: Crear la función en el AuthRepository para llamar a la API de autenticación de Supabase.
[ ] Frontend: Implementar la lógica de navegación para redirigir al usuario tras un login exitoso.
[ ] QA: Escribir pruebas unitarias para la lógica de validación de campos.
ID: VSTLAB-HU-002 (Historia de Usuario) - 3 Puntos
Historia: Como Asistente de Laboratorio, quiero registrar un nuevo activo en el sistema completando sus detalles para que quede centralizado y sea trazable desde su origen. Criterios de Aceptación:
Desde el Dashboard, un botón "Añadir Activo" navega al formulario de creación.
El formulario permite ingresar "Nombre", "Valor" y seleccionar "Sucursal Base".
El botón "Guardar" está deshabilitado si los campos obligatorios están vacíos. Tareas Técnicas:
[ ] Frontend: Crear la pantalla "Formulario de Activo" con los widgets de entrada de texto y selector.
[ ] Frontend: Implementar validación en tiempo real para los campos obligatorios.
[ ] Frontend: Implementar la lógica para guardar el nuevo activo en la base de datos local (sqflite) para funcionalidad offline.
[ ] Integración: Crear la función en el AssetRepository que sincroniza el nuevo activo con la tabla Assets de Supabase.
ID: VSTLAB-HU-003 (Historia de Usuario) - 2 Puntos
Historia: Como Asistente de Laboratorio, quiero generar y asociar un código QR único a un nuevo activo para poder identificarlo físicamente de forma instantánea. Criterios de Aceptación:
Tras guardar un nuevo activo, se presenta la pantalla "Generación de QR".
El QR mostrado es grande y claro.
Existen opciones para "Guardar Imagen en Galería" o "Compartir". Tareas Técnicas:
[ ] Backend: Implementar la lógica para generar un ID único para cada activo al ser creado.
[ ] Frontend: Añadir una librería de generación de QR a Flutter (ej: qr_flutter).
[ ] Frontend: Crear la pantalla que muestra el widget del QR generado a partir del ID del activo.
[ ] Frontend: Implementar la funcionalidad de guardado y compartido usando las APIs nativas del dispositivo.
ID: VSTLAB-HU-004 (Historia de Usuario) - 5 Puntos
Historia: Como Asistente de Laboratorio, quiero escanear el código QR de un activo para consultar su información detallada al instante y sin errores. Criterios de Aceptación:
El botón "Escanear QR" activa la cámara en menos de 1 segundo.
Al escanear un QR válido, se navega al "Detalle del Activo" en menos de 2 segundos.
Al escanear un QR no válido, se muestra un mensaje de error. Tareas Técnicas:
[ ] Frontend: Integrar una librería de escaneo de QR en Flutter (ej: mobile_scanner).
[ ] Frontend: Crear la pantalla de escaneo con la superposición visual de la cámara.
[ ] Integración: Implementar la lógica para tomar el valor del QR escaneado y buscar el activo correspondiente en el AssetRepository.
[ ] Frontend: Crear la pantalla de "Detalle del Activo" que muestra la información recuperada.
[ ] QA: Probar con diferentes condiciones de luz y ángulos de cámara.
ID: VSTLAB-HU-005 (Historia de Usuario) - 5 Puntos
Historia: Como Asistente de Laboratorio, quiero registrar un préstamo de un activo a un responsable para formalizar su salida y tener un registro claro de quién lo tiene. Criterios de Aceptación:
Desde el detalle de un activo "Disponible", el botón "Iniciar Préstamo" inicia el flujo.
El flujo permite seleccionar un responsable y una fecha de devolución.
Al confirmar, el estado del activo cambia a "Prestado" y se crea un registro en Loans. Tareas Técnicas:
[ ] Frontend: Crear la pantalla de selección de responsable (inicialmente una lista simple de usuarios).
[ ] Frontend: Integrar un widget de selector de fecha.
[ ] Frontend: Crear la pantalla de resumen/confirmación del préstamo.
[ ] Integración: Crear la función en el LoanRepository para crear el registro en la tabla Loans y actualizar el estado en la tabla Assets (transacción).
[ ] Frontend: Actualizar la UI del "Detalle del Activo" para reflejar el nuevo estado "Prestado".
ID: VSTLAB-HU-006 (Historia de Usuario) - 2 Puntos
Historia: Como Asistente de Laboratorio, quiero registrar la devolución de un activo prestado para cerrar el ciclo del préstamo y actualizar su disponibilidad en el sistema. Criterios de Aceptación:
Desde el detalle de un activo "Prestado", el botón principal es "Registrar Devolución".
Un modal de confirmación previene la acción accidental.
Al confirmar, el préstamo se marca como "Cerrado" y el estado del activo cambia a "Disponible". Tareas Técnicas:
[ ] Frontend: Modificar la pantalla "Detalle del Activo" para que muestre el botón "Registrar Devolución" cuando el estado es "Prestado".
[ ] Frontend: Implementar el modal de confirmación.
[ ] Integración: Crear la función en el LoanRepository para actualizar el estado del préstamo y del activo correspondiente.
[ ] Frontend: Asegurar que la UI se refresque instantáneamente para mostrar el estado "Disponible".

