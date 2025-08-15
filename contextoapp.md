**ID:** VSTLABManager-DVP-001
**Versión:** v1.0
**Fecha:** 2025-08-15
**Autor:** Estratega de Producto (Gem 1)

### Resumen Ejecutivo (máx. 10 líneas)
---
VSTLABManager es una aplicación móvil diseñada para la gestión y control total del inventario en laboratorios de clases distribuidos en múltiples colegios. La plataforma resuelve la pérdida de trazabilidad de activos, la incertidumbre sobre su disponibilidad y los gastos innecesarios en compras duplicadas. A través de una interfaz móvil, los usuarios pueden localizar herramientas, gestionar préstamos a personal interno y externo, y obtener visibilidad financiera del inventario. El éxito del producto se medirá por la reducción de costos en duplicados, el aumento en la disponibilidad de herramientas y la alta tasa de adopción del sistema por parte del personal.

### 1. Propósito del Producto
* Establecer un sistema centralizado y formal para la gestión de inventario que proporcione visibilidad, control y rendición de cuentas sobre todos los activos de los laboratorios. El objetivo es eliminar el desperdicio financiero causado por la compra de duplicados y minimizar la interrupción del trabajo debido a la pérdida o mala ubicación de herramientas.

### 2. Público Objetivo (User Personas)
* **Persona 1 (Operadores Diarios):** Asistente y Encargado de Laboratorio.
    * **Descripción:** Son los responsables de la operativa diaria. Utilizan la aplicación para registrar la entrada/salida de artículos, gestionar préstamos, actualizar ubicaciones y dar seguimiento a las devoluciones.
    * **Necesidad Clave:** Requieren un sistema extremadamente rápido y simple para no ralentizar su trabajo (ej: registrar un préstamo en pocos clics, encontrar una herramienta al instante).

* **Persona 2 (Gestores y Supervisores):** Supervisor y Gerente Principal.
    * **Descripción:** Son los responsables de la toma de decisiones estratégicas y la supervisión. Aunque tienen permisos para operar todo el sistema, su uso principal es la consulta.
    * **Necesidad Clave:** Requieren dashboards y reportes claros que muestren la disponibilidad de activos por sucursal, el valor total del inventario y el estado de los préstamos para garantizar la eficiencia operativa y el control financiero.

### 3. Problemas a Resolver
* **P1:** Pérdida de trazabilidad de herramientas y activos cuando se mueven entre los distintos laboratorios (colegios).
* **P2:** Gastos financieros innecesarios en la compra de activos duplicados por no conocer la ubicación o disponibilidad del original.
* **P3:** Interrupción del trabajo y pérdida de eficiencia cuando el personal no puede localizar una herramienta necesaria.
* **P4:** Falta de un sistema formal que impida la supervisión efectiva y la exigencia de rendición de cuentas sobre el inventario.
* **P5:** Desconocimiento del valor financiero total del inventario invertido en cada laboratorio y en la organización en general.

### 4. Propuesta de Valor Única (UVP)
* **VSTLABManager:** El control total de tu inventario de laboratorio en la palma de tu mano. Localiza cada herramienta al instante, gestiona préstamos de forma responsable y elimina para siempre los gastos duplicados con una aplicación móvil simple y centralizada para todos tus colegios.

### 5. KPIs de Éxito
* **KPI 1 (Financiero):** Reducir en un 25% la compra de activos duplicados en los primeros 6 meses.
* **KPI 2 (Operativo):** Aumentar la disponibilidad de herramientas críticas en un 95% en los primeros 6 meses.
* **KPI 3 (Adopción):** Lograr que el 90% de los movimientos de inventario (préstamos, devoluciones, traslados) se registren a través de la aplicación después de los primeros 3 meses de uso.

### 6. Riesgos y Supuestos Clave
* **Riesgo:** El personal de los laboratorios puede percibir el registro de cada movimiento como una carga de trabajo adicional y resistirse a la adopción del sistema.
* **Riesgo:** La conectividad a internet en algunas ubicaciones de los colegios podría ser inestable, afectando la usabilidad de la aplicación en tiempo real.
* **Supuesto:** Todo el personal designado para usar la aplicación dispone de un smartphone compatible y está dispuesto a utilizarlo para esta tarea laboral.
* **Supuesto:** La gerencia apoyará activamente la implementación y exigirá el uso del sistema, proporcionando la formalidad que los métodos anteriores no tenían.

### 7. Mapa Problema-Solución
| Problema                               | Solución Propuesta                                                                                                |
| :------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| **P1:** Pérdida de trazabilidad entre laboratorios. | Funcionalidad de múltiples sucursales, búsqueda global de activos y asignación clara de cada ítem a un laboratorio base. |
| **P2/P3:** Gastos duplicados e interrupción del trabajo. | Visibilidad en tiempo real de la ubicación y estado ("disponible", "prestado") de cada herramienta.                               |
| **P4:** Falta de un sistema formal y accountability. | Módulo de préstamos que registra responsable, fecha de devolución y envía recordatorios automáticos. Perfiles de usuario con historial de actividades. |
| **P5:** Desconocimiento del valor financiero.       | Cada artículo en el inventario tendrá un campo para registrar su valor, permitiendo generar reportes consolidados del valor total de los activos. |
| Necesidad de identificación rápida.         | Generación de códigos QR/Barras para cada artículo, que pueden ser escaneados con la cámara del celular para una identificación y consulta instantánea. |

Informe de Estrategia de Negocio y Desarrollo de Productos: VSTLABManager
Fecha: 2025-08-15 Autor: Estratega de Producto (Gem 1) Proyecto ID: VSTLABManager-DVP-001
1. Introducción: La Necesidad Estratégica de un Control Centralizado
Este informe detalla la estrategia subyacente para el desarrollo de VSTLABManager, una aplicación móvil de gestión de inventario. La iniciativa surge de una serie de problemas operativos y financieros recurrentes que afectan la eficiencia de los laboratorios distribuidos en múltiples colegios. La falta de un sistema formal ha llevado a un estado de descontrol reactivo, caracterizado por la interrupción del trabajo y gastos innecesarios. VSTLABManager no se concibe como una simple herramienta de seguimiento, sino como un activo estratégico diseñado para imponer orden, visibilidad y responsabilidad, transformando la gestión de inventario de un centro de costos a un pilar de eficiencia operativa.
2. Análisis del Problema: Más Allá de la Herramienta Perdida
El análisis de la situación actual reveló que los problemas no son incidentes aislados, sino síntomas de una falla sistémica más profunda.
El Impacto Financiero del Desorden: El problema más crítico identificado es el gasto recurrente en activos duplicados. Esta no es una simple ineficiencia; es una fuga de capital directa que impacta el presupuesto de la organización. La incapacidad de localizar una herramienta no solo detiene el trabajo, sino que desencadena un ciclo de compras innecesarias. Un sistema improvisado como WhatsApp ha demostrado ser ineficaz para mitigar este problema, ya que la información se pierde y no existe un registro auditable.
La Cadena de Fricción Operativa: La pérdida de trazabilidad es el catalizador de la ineficiencia. Un supervisor que traslada una herramienta entre sucursales sin un registro formal crea una "deuda de información" que debe ser "pagada" más tarde con tiempo perdido en búsquedas, llamadas y frustración. Esto interrumpe directamente la labor educativa y técnica en los laboratorios, afectando la calidad del servicio.
El Vacío de Responsabilidad: Quizás el hallazgo más revelador fue que la falta de un sistema formal impide la supervisión y la exigencia de rendición de cuentas. Un método improvisado no puede ser auditado, medido ni mejorado. Esto crea una cultura donde la responsabilidad sobre los activos es difusa, perpetuando el ciclo de pérdida y descontrol.
3. Estrategia de Producto: Simplicidad y Control para Múltiples Roles
La solución debe atender las necesidades de un espectro diverso de usuarios, desde la operación diaria hasta la supervisión estratégica.
Diseño Centrado en la Eficiencia: Para los Asistentes y Encargados de Laboratorio, la velocidad y la simplicidad no son un lujo, sino un requisito fundamental. La aplicación debe ser más rápida y fácil que cualquier método manual. Acciones como escanear un código QR para ver el estado de un activo o registrar un préstamo en menos de tres interacciones son cruciales para garantizar la adopción. Si la herramienta se percibe como una carga, fracasará.
Visibilidad para la Toma de Decisiones: Para los Supervisores y Gerentes, el valor reside en la agregación de datos. La capacidad de ver un dashboard consolidado con el valor total del inventario por sucursal o identificar qué herramientas están próximas a su fecha de devolución es lo que permitirá una gestión proactiva. La aplicación les dará el poder no solo de operar, sino de supervisar y optimizar el uso de los activos a nivel organizacional.
Flexibilidad para el Ecosistema Escolar: La necesidad de gestionar préstamos a personal externo (de los colegios) amplía el alcance del sistema y lo convierte en una herramienta de servicio a la comunidad. Esto requiere una gestión de contactos simple pero efectiva, asegurando que los activos prestados fuera del círculo de empleados directos también estén bajo control.
4. Medición del Éxito: Alineando los KPIs con los Objetivos de Negocio
La efectividad de VSTLABManager se medirá con tres indicadores clave que están directamente vinculados a la solución de los problemas fundamentales identificados:
KPI Financiero (Reducir en un 25% la compra de duplicados): Este es el indicador más directo del retorno de la inversión (ROI). Ataca el problema del gasto innecesario y justifica financieramente el proyecto.
KPI Operativo (Aumentar la disponibilidad de herramientas al 95%): Este KPI mide la solución al problema de la interrupción del trabajo. Una alta disponibilidad significa menos tiempo perdido en búsquedas y más tiempo dedicado a tareas productivas.
KPI de Adopción (90% de los movimientos registrados): Este es el KPI fundamental que habilita a los otros dos. Sin una adopción masiva, los datos del sistema no serán fiables y los beneficios financieros y operativos no se materializarán. Mide el éxito del cambio cultural hacia un proceso formal y responsable.
5. Conclusión y Próximos Pasos
VSTLABManager está estratégicamente posicionado para resolver problemas críticos de control, eficiencia y finanzas. El Documento de Visión del Producto (DVP) ha establecido el "qué" y el "para quién". Este informe ha articulado el "porqué".
El siguiente paso es avanzar hacia la definición del Producto Mínimo Viable (MVP). El enfoque debe ser entregar el ciclo completo de valor para una sola sucursal: registrar un activo, generar su QR, prestarlo, recibirlo y poder buscarlo. La gestión de múltiples sucursales y los dashboards complejos pueden ser parte de una segunda fase. El objetivo inmediato es validar que el personal adoptará el proceso central en un entorno controlado, mitigando así el principal riesgo del proyecto: la resistencia al cambio.


Documento de Diseño de Arquitectura (DDA)
ID: VSTLABManager-DDA-001 Versión: 1.0 Fecha: 2025-08-15 Autor: Arquitecto de Soluciones Híbrido (gem2) Documentos de Referencia: VSTLABManager-DVP-001, VSTLABManager-RDA-001

1. Introducción
Este documento describe la arquitectura de software para la aplicación VSTLABManager. El diseño se basa en los requisitos definidos en el Documento de Visión de Producto (DVP) y las decisiones tomadas durante la fase de consulta, resumidas en el Registro de Decisión de Arquitectura (RDA). El objetivo es crear un sistema robusto, escalable y de alto rendimiento que cumpla con las necesidades de los operadores y gestores de laboratorio.

2. Vista Lógica y de Componentes
La arquitectura de VSTLABManager se compone de tres componentes principales que interactúan entre sí.
Aplicación Cliente Móvil (Frontend):
Descripción: Una aplicación multiplataforma (iOS y Android) desarrollada en Flutter. Es el único punto de interacción para los usuarios finales.
Responsabilidades:
Presentar la interfaz de usuario para la gestión de inventario, préstamos y reportes.
Capturar datos a través de formularios y escaneo de códigos QR.
Almacenar datos en una base de datos local para permitir la funcionalidad offline.
Gestionar la lógica de negocio del lado del cliente y el estado de la aplicación usando el patrón Riverpod.
Sincronizar los datos locales con el backend de Supabase de manera asíncrona.
Backend Centralizado (BaaS - Backend as a Service):
Descripción: La plataforma Supabase actúa como nuestro backend. Proporciona la base de datos, la autenticación y las APIs necesarias.
Responsabilidades:
Servir como la única fuente de verdad para todos los datos del inventario.
Proveer una base de datos PostgreSQL para el almacenamiento persistente.
Exponer automáticamente una API RESTful y en tiempo real para que la aplicación cliente la consuma.
Gestionar la autenticación de usuarios y los roles (Operadores, Gestores).
Base de Datos Local (en el dispositivo):
Descripción: Una base de datos SQL (por ejemplo, sqflite) integrada en la aplicación Flutter.
Responsabilidades:
Almacenar una copia de los datos relevantes para el usuario (inventario de su sucursal, préstamos activos).
Permitir que la aplicación realice todas las operaciones CRUD (Crear, Leer, Actualizar, Borrar) sin necesidad de una conexión a internet activa.

3. Patrones Arquitectónicos
Patrón General: Offline-First
Este es el patrón principal del sistema. Todas las operaciones del usuario en la aplicación móvil se realizan contra la base de datos local, garantizando una respuesta instantánea. Un servicio de sincronización en segundo plano se encarga de enviar los cambios locales al backend de Supabase y de recibir las actualizaciones del servidor cuando la conexión está disponible. Esto mitiga el riesgo de conectividad inestable.
Patrón de Gestión de Estado: Riverpod
Dentro de la aplicación Flutter, se utilizará Riverpod para la gestión del estado y la inyección de dependencias. Se definirá un Repository que abstraiga las fuentes de datos (local o remota) y StateNotifierProviders que expondrán el estado a la UI, manteniendo una separación limpia entre la lógica de negocio y la presentación.

4. Vista de Datos
El modelo de datos se gestionará en la base de datos PostgreSQL de Supabase. Las entidades principales incluyen:
Activo (Asset): Representa un ítem del inventario (nombre, descripción, valor, código QR, sucursal_base_id, estado).
Sucursal (Branch): Representa un laboratorio o colegio.
Usuario (User): Contiene la información de los usuarios del sistema y su rol.
Préstamo (Loan): Registra el activo prestado, el responsable, la fecha de préstamo y la fecha de devolución esperada.
Se establecerán relaciones claras entre estas entidades (ej: un Préstamo se relaciona con un Activo y un Usuario).

5. Pila Tecnológica (Stack)
Frontend Móvil: Flutter
Backend y Base de Datos: Supabase (con PostgreSQL)
Gestión de Estado (Flutter): Riverpod

Informe de Justificación de Arquitectura
ID: VSTLABManager-IJA-001 Versión: 1.0 Fecha: 2025-08-15 Autor: Arquitecto de Soluciones Híbrido (gem2)

1. Introducción
El propósito de este informe es justificar las decisiones arquitectónicas tomadas para el proyecto VSTLABManager, detalladas en el DDA. La selección de cada componente y patrón se ha realizado para cumplir con los objetivos de negocio, mitigar los riesgos identificados y satisfacer los KPIs de éxito definidos en el DVP.

2. Resumen de Decisiones Clave
La arquitectura seleccionada se basa en un patrón Offline-First implementado con una aplicación móvil en Flutter, que utiliza Riverpod para la gestión de estado y se comunica con Supabase como backend y base de datos.

3. Justificación de Decisiones Arquitectónicas
Elección del Patrón "Offline-First"
Problema: El DVP identifica la "conectividad a internet inestable" como un riesgo clave que podría impedir la adopción del sistema.
Justificación: Una arquitectura Offline-First elimina esta dependencia como punto de fallo. Los operadores pueden realizar sus tareas críticas (registrar préstamos, consultar inventario) en cualquier momento y lugar dentro de las instalaciones. Esto impacta directamente en el KPI de Adopción (KPI 3), al ofrecer una experiencia de usuario fiable y sin frustraciones, y en el KPI Operativo (KPI 2), al garantizar que la herramienta esté siempre disponible.
Elección de Supabase (Backend y Base de Datos)
Problema: Necesidad de un backend centralizado, seguro y escalable sin incurrir en largos tiempos de desarrollo de una API a medida.
Justificación: Supabase fue elegido por su eficiencia. Al ser una solución BaaS, acelera drásticamente el desarrollo al proveer una base de datos PostgreSQL robusta, APIs automáticas y un sistema de autenticación listo para usar. Esto reduce costos y permite al equipo de desarrollo centrarse en la lógica de negocio y la experiencia de usuario de la aplicación móvil, contribuyendo a un lanzamiento más rápido del producto.
Elección de Flutter (Frontend Móvil)
Problema: La necesidad de una aplicación para iOS y Android que sea rápida, simple y mantenible.
Justificación: Flutter fue seleccionado sobre el desarrollo nativo por su capacidad de generar aplicaciones para ambas plataformas desde un único código base, reduciendo costos y tiempo de desarrollo. Su motor de renderizado de alto rendimiento asegura una interfaz fluida y receptiva, lo cual es fundamental para cumplir con la necesidad clave de los "Operadores Diarios" de tener un sistema que no ralentice su trabajo.
Elección de Riverpod (Gestión de Estado)
Problema: La aplicación necesita una forma estructurada y eficiente de manejar el estado, especialmente la compleja lógica de sincronización de datos.
Justificación: Se eligió Riverpod sobre otras opciones como BLoC porque ofrece el equilibrio perfecto entre una estructura sólida y la velocidad de desarrollo. Es lo suficientemente potente como para manejar la lógica offline de forma testeable y mantenible, pero con menos código repetitivo, lo que agiliza el proceso de desarrollo.

4. Alineación con los Objetivos de Negocio
La arquitectura propuesta está directamente alineada con los objetivos de VSTLABManager:
Reducir Gastos (KPI 1): El sistema centralizado en Supabase y la visibilidad en tiempo real en la app Flutter permiten conocer la disponibilidad de activos al instante, atacando la causa raíz de las compras duplicadas.
Aumentar Disponibilidad (KPI 2): El patrón Offline-First garantiza que la aplicación sea siempre funcional, permitiendo al personal localizar y gestionar herramientas sin interrupciones.
Lograr Adopción (KPI 3): La combinación de una UI rápida (Flutter) y una operativa ininterrumpida (Offline-First) crea una experiencia de usuario superior que incentiva la adopción y el registro constante de movimientos.

5. Conclusión
La arquitectura definida es una solución moderna, eficiente y de bajo riesgo. Mitiga directamente las principales amenazas identificadas en el DVP (conectividad y resistencia del usuario) y proporciona una base tecnológica sólida para cumplir y superar los KPIs financieros y operativos del proyecto VSTLABManager.


Canvas Maestro: VSTLABManager
ID del Proyecto: VSTLABManager-FINAL-001
Fecha de Creación: 2025-08-15
Autor: Director de Diseño AI (Gem 3)

Fase 1: Generación del "Design Brief" (Kit de UI Textual) - (Revisado)
Basado en el análisis de los documentos, la identidad de VSTLABManager debe proyectar confianza, eficiencia y control absoluto. El diseño será limpio, moderno y funcional, adoptando un enfoque "móvil-first" para garantizar una experiencia de usuario extremadamente rápida y sin fricciones para los operadores en el terreno. La paleta de colores se centrará en un azul corporativo que inspira seguridad y profesionalismo, combinado con verdes para acciones de éxito y confirmación, y una gama de grises neutros para mantener la interfaz despejada y legible. La tipografía principal será Roboto, una fuente sans-serif versátil y moderna, seleccionada por su alta legibilidad en pantallas móviles, asegurando que los datos y los reportes sean fáciles de consumir de un vistazo y consolidando una estética de herramienta de gestión seria y robusta.
Fase 2: Definición de TODOS los Flujos de Usuario de la Aplicación (Formato Detallado Restaurado)
A. Flujos Fundamentales del Activo (Ciclo de Vida CRUD)
Flujo: Registrar un Nuevo Activo en el Sistema (Create)
Objetivo: Dar de alta un nuevo activo en el inventario central y prepararlo para su seguimiento físico.
Pasos:
El usuario (Operador) navega a la pestaña "Inventario" y pulsa el botón de acción flotante "Añadir Nuevo Activo".
Se presenta la pantalla "Formulario de Activo", donde completa los campos requeridos: Nombre, Descripción, Valor y Sucursal Base a la que pertenece.
Pulsa el botón "Guardar y Generar QR".
La app valida los datos, crea el nuevo registro en la base de datos y presenta la pantalla "Generación de QR".
Esta pantalla muestra el código QR único del nuevo activo, junto con opciones para "Guardar en Galería" o "Compartir", facilitando su impresión para adherirlo al ítem físico.
Flujo: Consultar Información de un Activo (Read)
Objetivo: Obtener de forma inmediata toda la información relevante de un activo, incluyendo su estado y ubicación.
Pasos (2a - Vía Escaneo QR):
El usuario (Operador) pulsa el botón principal "Escanear QR" desde el Dashboard.
La app activa la "Interfaz de Escaneo QR" (la cámara del dispositivo).
El usuario enfoca el código QR del activo físico.
Tras una lectura exitosa, la app navega instantáneamente a la pantalla "Detalle del Activo" correspondiente.
Pasos (2b - Vía Búsqueda Manual):
El usuario navega a la pestaña "Inventario/Búsqueda".
Utiliza la barra de búsqueda para escribir el nombre o código del activo.
La app muestra una lista de resultados en tiempo real.
El usuario pulsa sobre el activo deseado en la lista para acceder a la pantalla "Detalle del Activo".
Flujo: Editar la Información de un Activo (Update)
Objetivo: Corregir o actualizar los datos registrados de un activo existente para mantener la precisión del inventario.
Pasos:
El usuario llega a la pantalla "Detalle del Activo" utilizando cualquiera de los métodos del Flujo 2.
Pulsa el icono de "Opciones" (menú de 3 puntos) y selecciona "Editar".
La app presenta el "Formulario de Activo", precargado con la información existente del ítem.
El usuario modifica los campos necesarios (ej. actualiza el valor monetario).
Pulsa "Guardar Cambios" para confirmar la actualización en la base de datos.
Flujo: Dar de Baja un Activo (Delete/Archive)
Objetivo: Retirar formalmente un activo del inventario funcional, manteniendo un registro de su salida.
Pasos:
El usuario llega a la pantalla "Detalle del Activo".
Pulsa el icono de "Opciones" y selecciona "Dar de Baja".
Aparece un "Modal de Confirmación" que solicita seleccionar un motivo (ej: Dañado, Perdido, Obsoleto) de una lista.
Tras seleccionar el motivo y confirmar, el activo se marca como "Inactivo" y deja de aparecer en las búsquedas y reportes de inventario activo.
B. Flujos de Operación Diaria (Movimientos y Trazabilidad)
Flujo: Registrar un Préstamo a un Responsable
Objetivo: Formalizar la salida de un activo del inventario de forma auditable, asignando un responsable y una fecha de devolución.
Pasos:
Desde la pantalla "Detalle del Activo" (que debe estar en estado "Disponible"), el usuario pulsa el botón principal "Iniciar Préstamo".
La app presenta la pantalla "Selección de Responsable", que incluye una barra de búsqueda.
El usuario busca y selecciona a la persona (sea personal interno o un contacto externo registrado).
A continuación, la app solicita establecer la fecha de devolución, mostrando una fecha sugerida por defecto (ej. 7 días).
Se muestra una pantalla de "Confirmación de Préstamo" con un resumen claro: foto/nombre del activo, nombre del responsable y fecha de devolución.
El usuario pulsa "Confirmar Préstamo". El estado del activo se actualiza a "Prestado" y la transacción queda registrada.
Flujo: Procesar la Devolución de un Activo Prestado
Objetivo: Registrar el reingreso de un activo, liberar al responsable de su custodia y actualizar el estado del inventario a "Disponible".
Pasos:
El usuario escanea el QR del activo que está siendo devuelto (método preferido) o lo busca manualmente.
La app muestra la pantalla "Detalle del Activo", que ahora está en estado "Prestado", indicando quién es el responsable y la fecha de devolución.
El usuario pulsa el botón principal "Registrar Devolución".
Aparece un "Modal de Confirmación" para evitar acciones accidentales.
Tras la confirmación, el sistema cierra el préstamo, y el estado del activo cambia inmediatamente a "Disponible".
Flujo: Trasladar un Activo entre Sucursales
Objetivo: Mantener una trazabilidad precisa cuando la ubicación base de un activo cambia de forma permanente.
Pasos:
El usuario llega a la pantalla "Detalle del Activo".
Pulsa el icono de "Opciones" y selecciona "Trasladar Activo".
La app presenta la pantalla "Selección de Sucursal" con una lista de todos los laboratorios/colegios disponibles.
El usuario selecciona la nueva sucursal de destino y pulsa "Confirmar Traslado".
El campo "Sucursal Base" del activo se actualiza en la base de datos.
C. Flujos de Supervisión y Reportes (Gestores)
Flujo: Supervisar el Estado General del Inventario
Objetivo: Obtener una visión macro y en tiempo real de los indicadores clave de rendimiento (KPIs) del inventario para la toma de decisiones estratégicas.
Pasos:
Un usuario con rol de Supervisor inicia sesión y aterriza en el "Dashboard del Supervisor".
El dashboard muestra tarjetas de KPI destacadas: Valor total del inventario, Número de activos prestados y Número de activos con devolución vencida.
El supervisor utiliza un menú desplegable en la parte superior para filtrar todas las métricas del dashboard por una sucursal específica o ver el consolidado de "Todas las Sucursales".
Flujo: Consultar Reportes Detallados
Objetivo: Realizar un análisis profundo y granular del estado de los activos y préstamos para auditoría y gestión.
Pasos:
Desde la navegación principal, el supervisor accede a la sección de "Reportes".
Se le presentan opciones para ver el "Reporte de Inventario General" o el "Reporte de Préstamos".
Al seleccionar un reporte, ve una lista detallada con toda la información.
Utiliza las herramientas de filtro avanzadas para acotar los datos por rango de fechas, estado del préstamo (Activo/Vencido), sucursal, etc.
D. Flujos de Administración y Cuenta de Usuario
Flujo: Autenticación de Usuario
Objetivo: Garantizar el acceso seguro a la aplicación y sus funcionalidades según el rol del usuario.
Pasos (Login): El usuario abre la aplicación y se le presenta la "Pantalla de Login". Ingresa su email y contraseña y pulsa "Ingresar".
Pasos (Logout): El usuario navega a la pestaña "Perfil", pulsa el botón "Cerrar Sesión" y lo confirma en un diálogo para salir de su cuenta.
Flujo: Recuperación de Contraseña
Objetivo: Proveer un método seguro para que los usuarios puedan restablecer su contraseña en caso de olvido.
Pasos:
En la "Pantalla de Login", el usuario pulsa el enlace "¿Olvidaste tu contraseña?".
Se le dirige a la "Pantalla de Recuperación", donde debe ingresar su dirección de email registrada.
El sistema envía un correo electrónico con un enlace o código de un solo uso.
El usuario sigue las instrucciones del correo para establecer una nueva contraseña y recuperar el acceso.
Flujo: Gestión de Perfil Personal
Objetivo: Permitir al usuario mantener actualizada su información personal y sus credenciales de seguridad.
Pasos:
El usuario navega a la pestaña "Perfil".
La pantalla muestra su nombre, rol y email.
Pulsa la opción "Cambiar Contraseña".
Es dirigido a una nueva pantalla donde debe ingresar su contraseña actual y luego la nueva contraseña dos veces para confirmarla.
E. Flujos de Inventario Jerárquico (Contenedores) - (Actualizado)
Flujo: Crear y Gestionar un Contenedor (Caja, Estante)
Objetivo: Crear y poblar unidades de inventario virtuales (contenedores) para agrupar activos.
Pasos de Creación:
El usuario navega a "Inventario", va a "Gestionar Contenedores" y pulsa "Crear Nuevo Contenedor".
Completa el formulario (Nombre, Ubicación) y la app genera el QR del Contenedor para su impresión.
Pasos de Asignación (Método 1 - Manual por Lista):
Tras crear el contenedor, pulsa "Asignar Activos".
Selecciona los ítems de una lista de activos no asignados de la sucursal y confirma.
Pasos de Asignación (Método 2 - Rápido por QR):
El usuario selecciona la opción "Asignación Rápida por QR" en la app.
Paso A: La app solicita: "Escanee el QR del CONTENEDOR". El usuario escanea el QR de la caja/estante.
Paso B: La app confirma el contenedor y solicita: "Escanee el QR del ACTIVO a guardar".
El usuario escanea el QR del ítem. La app emite una confirmación sonora/visual y queda lista para escanear el siguiente activo, permitiendo un proceso de guardado rápido y secuencial.
Flujo: Consultar y Operar Activos Dentro de un Contenedor
Objetivo: Escanear un solo QR en una caja o estante para ver todo su contenido y poder operar sobre un ítem específico sin tener que buscarlo individualmente.
Pasos:
El usuario escanea el código QR pegado en el exterior de un contenedor físico (caja, estante).
La app no muestra un detalle de activo, sino la nueva "Vista de Contenedor".
Esta vista muestra el nombre del contenedor y una lista de todos los activos que contiene, cada uno con su estado actual ("Disponible" o "Prestado a...").
El usuario puede visualizar rápidamente todo el contenido sin abrir la caja.
Si desea tomar un ítem, simplemente pulsa sobre un activo disponible en la lista.
La app navega a la pantalla "Detalle del Activo" de ese ítem específico, desde donde puede iniciar el flujo normal de préstamo (Flujo 5).
F. Flujos de Seguimiento y Notificaciones - (Actualizado)
Flujo: Gestionar y Enviar Recordatorios de Devolución
Objetivo: Notificar proactivamente a los responsables sobre préstamos vencidos usando múltiples canales.
Pasos:
Un Supervisor accede a la lista de préstamos "Vencidos" a través del Dashboard o Reportes.
Junto a cada préstamo, pulsa el botón "Enviar Recordatorio".
Aparece un modal con opciones de canal: "Enviar por Email" y "Enviar por WhatsApp".
Si elige "Email": El sistema envía un correo pre-formateado automáticamente.
Si elige "WhatsApp": La app abre la aplicación de WhatsApp en el dispositivo del supervisor, precargando el número del responsable y un mensaje de plantilla (ej: "Hola [Nombre], te recordamos que el activo [Nombre del Activo] que tomaste prestado el [Fecha] ya ha vencido. Por favor, coordina su devolución. Gracias.").
El supervisor solo tiene que pulsar "Enviar" en WhatsApp. El sistema registra que se intentó contactar por este medio.
G. Flujos de Visualización y Exploración
Flujo: Explorar el Inventario Completo de una Sucursal
Objetivo: Permitir a cualquier usuario ver de forma rápida y sencilla todos los activos que pertenecen a un laboratorio o colegio específico.
Pasos:
El usuario navega a la pestaña "Inventario/Búsqueda".
En la parte superior de la pantalla, se muestra un selector de sucursal, que por defecto muestra la sucursal del usuario.
El usuario pulsa este selector, y se despliega una lista de todas las sucursales disponibles.
Al elegir una sucursal, la lista de activos en pantalla se actualiza instantáneamente, mostrando el inventario completo (tanto activos individuales como contenedores) de la ubicación seleccionada.
H. Flujos de Gestión Avanzada y Control (Nuevos)
Flujo: Gestión de Mantenimiento y Calibración
Objetivo: Registrar y ser notificado sobre el mantenimiento requerido para equipos específicos, asegurando su operatividad y longevidad.
Pasos:
Al editar un activo, un Supervisor puede acceder a una sección de "Mantenimiento".
Allí puede registrar eventos pasados (ej. "Cambio de filtro - 10/08/2025") y programar la fecha del "Próximo Mantenimiento".
El sistema generará notificaciones en el dashboard del supervisor cuando estas fechas se aproximen.
Se puede marcar un activo como "En Mantenimiento", bloqueándolo temporalmente para préstamos.
Flujo: Alertas de Inventario Bajo para Consumibles
Objetivo: Evitar interrupciones por falta de stock de ítems consumibles.
Pasos:
Al crear/editar un activo, se puede categorizar como "Consumible" y establecer un "Umbral de Stock Mínimo".
El sistema monitorea la cantidad de ítems disponibles de esa categoría.
Cuando la cantidad cruza el umbral, se genera una alerta visible en el Dashboard del Supervisor, indicando la necesidad de reposición.
Flujo: Realizar una Auditoría de Inventario
Objetivo: Verificar que el inventario registrado en el sistema coincide con los activos físicos presentes en un laboratorio.
Pasos:
Un Supervisor inicia el "Modo Auditoría" para una sucursal específica.
La app presenta una checklist de todos los activos que deberían estar en esa ubicación.
El supervisor recorre el laboratorio escaneando con la app cada QR que encuentra. Los ítems se van marcando como "Verificado".
Al finalizar, la app genera un "Reporte de Auditoría" con tres listas: Ítems Verificados, Ítems No Encontrados (posibles extravíos), e Ítems Encontrados que pertenecen a otra sucursal.
Flujo 20: Onboarding para Nuevos Usuarios
Objetivo: Guiar a un usuario en su primer inicio de sesión a través de las funcionalidades más importantes de la aplicación. El fin es acelerar la adopción, reducir la necesidad de capacitación externa y asegurar que el usuario comprenda el valor de la herramienta desde el primer minuto.
Pasos:
El usuario inicia sesión en la aplicación por primera vez. El sistema lo detecta y, en lugar de dirigirlo al Dashboard, inicia la secuencia de Onboarding.
Se presenta la primera pantalla de bienvenida: una ilustración grande y amigable (ej. un código QR y una lupa), un título claro como "Todo a la Mano" y un texto breve: "Escanea el código QR de cualquier activo para ver su estado y ubicación al instante."
El usuario desliza hacia la izquierda o pulsa "Siguiente".
Aparece la segunda pantalla: una ilustración (ej. una herramienta pasando de una mano a otra con un check), el título "Préstamos Responsables" y el texto: "Registra préstamos en segundos y mantén un control claro de quién tiene cada herramienta."
El usuario desliza de nuevo.
Se muestra la tercera y última pantalla: una ilustración (ej. varios ítems dentro de un ícono de caja), el título "Organización Eficiente" y el texto: "Agrupa activos en contenedores para saber qué hay en cada caja o estante sin tener que abrirlos."
En esta última pantalla, en lugar de "Siguiente", hay un botón de acción principal con el texto "¡Entendido, a Trabajar!". Al pulsarlo, el usuario es dirigido finalmente a su Dashboard principal. El Onboarding no se volverá a mostrar.
Flujo 21: Administración de Usuarios (Para Gerentes/Administradores)
Objetivo: Permitir a un usuario con privilegios de Administrador crear, ver y gestionar las cuentas de los usuarios del sistema, asignando roles y sucursales para controlar el acceso y los permisos.
Pasos:
Un usuario con rol de "Administrador" inicia sesión y navega a una nueva sección en el menú llamada "Administración".
Dentro de esta sección, pulsa la opción "Gestionar Usuarios".
Se le presenta la pantalla "Lista de Usuarios", que muestra a todos los empleados registrados, junto con su rol (Operador/Supervisor) y sucursal.
El administrador pulsa un Botón de Acción Flotante (FAB) con un ícono de "+".
Navega al "Formulario de Creación de Usuario", donde ingresa los datos de la nueva persona: Nombre, Correo Electrónico, y establece una contraseña temporal.
Crucialmente, utiliza dos menús desplegables para asignar el Rol ("Operador" o "Supervisor") y la Sucursal Base a la que pertenece el nuevo usuario.
Al pulsar "Guardar", la cuenta se crea y el nuevo usuario ya puede iniciar sesión con las credenciales proporcionadas.
Flujo 22: Gestión de Contactos Externos
Objetivo: Centralizar la gestión de la base de datos de personas no empleadas (ej. personal de colegios) que pueden recibir activos en préstamo, permitiendo añadir, ver y editar su información.
Pasos:
Un Supervisor o Administrador navega a la sección de "Administración" y selecciona "Gestionar Contactos Externos".
Se muestra la pantalla "Lista de Contactos Externos", con todas las personas ajenas a la empresa que han sido registradas.
El usuario puede pulsar sobre cualquier contacto de la lista para ver sus detalles y acceder a un botón de "Editar" para actualizar su información (ej. cambiar un número de teléfono).
Desde la lista, también puede pulsar un FAB con un ícono "+" para ir al "Formulario de Creación de Contacto Externo".
En el formulario, completa los campos relevantes: Nombre Completo, Institución (Colegio), Cédula o ID de identificación y datos de contacto como teléfono o email.
Al guardar, este nuevo contacto queda inmediatamente disponible en la pantalla de "Seleccionar Responsable" la próxima vez que se registre un préstamo.


Fase 3: Generación del "Shot List" (Final y Definitiva)
Esta lista de pantallas está 100% alineada con los 19 flujos detallados anteriormente.
Módulo de Autenticación y Cuenta (4 pantallas):
Pantalla de Login
Pantalla de Recuperación de Contraseña
Pantalla de Gestión de Perfil
Pantalla de Cambio de Contraseña
Módulo Central y Navegación (4 pantallas): 5. Navegación Principal (Barra de Pestañas) 6. Dashboard del Operador 7. Dashboard del Supervisor 8. Interfaz de Escaneo QR
Módulo de Gestión de Inventario (8 pantallas): 9. Pantalla de Inventario/Búsqueda (con selector de sucursal) 10. Pantalla de Detalle del Activo (vista unificada y adaptable) 11. Pantalla de Formulario de Activo (para Crear/Editar, con sección de Mantenimiento) 12. Pantalla de Generación de QR (para Activos y Contenedores) 13. Pantalla de Gestión de Contenedores (lista de contenedores y botón de crear) 14. Pantalla de Vista de Contenido de un Contenedor (muestra los activos dentro) 15. Interfaz de Asignación Rápida por QR (vista dual para escanear contenedor y luego activos) 16. Modal de Confirmación de "Dar de Baja"
Módulo de Préstamos y Recordatorios (3 pantallas): 17. Pantalla de Iniciar Préstamo (Selección de Responsable) 18. Pantalla de Confirmación de Préstamo 19. Modal de Selección de Canal de Recordatorio (con opciones de Email y WhatsApp)
Módulo de Reportes y Auditoría (3 pantallas): 20. Pantalla de Reporte de Inventario General 21. Pantalla de Reporte de Préstamos (con filtros y botón de recordatorio) 22. Pantalla de Modo Auditoría (con checklist y escáner integrado)
Bloque 6: Administración
Pantalla de Administración: Menú principal para Gerentes.
Pantalla de Lista de Usuarios
Formulario de Creación/Edición de Usuario
Pantalla de Lista de Contactos Externos
Formulario de Creación/Edición de Contacto Externo


Fase 4 Plantillas

Pantalla y Objetivo:
Pantalla: 1. Pantalla de Login.
Objetivo: Permitir a los usuarios acceder de forma segura a la aplicación, ya sea con sus credenciales tradicionales o utilizando su cuenta de Google para un acceso más rápido.
Estilo y Composición:
Estilo: Fiel al Design Brief, el estilo es profesional, limpio y minimalista. La composición es vertical y centrada. Se introduce un separador visual para diferenciar claramente el método de inicio de sesión tradicional de la opción de inicio de sesión social.
Composición: El layout sigue un flujo vertical claro. El logo y el saludo en la parte superior, seguidos por el bloque de inicio de sesión con email/contraseña. A continuación, un separador introduce el botón de Google, y finalmente, el enlace de recuperación, manteniendo todo perfectamente organizado y fácil de seguir.
Componentes Detallados:
[Elemento 1] Logo VSTLABManager: En la parte superior y centrado, se muestra el logo de la marca, nítido y prominente.
[Elemento 2] Texto de Bienvenida: Debajo del logo, un título en Roboto Bold, tamaño 24pt, dice: "Bienvenido de vuelta". Justo debajo, un subtítulo en Roboto Regular, tamaño 16pt y color gris medio, indica: "Ingresa tus credenciales para continuar".
[Elemento 3] Campo de Texto - Correo Electrónico: Un campo de entrada de texto de ancho completo con esquinas redondeadas, borde sutil, ícono de sobre a la izquierda y la etiqueta "Correo Electrónico".
[Elemento 4] Campo de Texto - Contraseña: Idéntico en estilo, con ícono de candado a la izquierda y un ícono de "ojo" a la derecha para alternar la visibilidad. La etiqueta es "Contraseña".
[Elemento 5] Botón Principal - "Ingresar": Un botón de ancho completo en el azul corporativo primario. El texto "Ingresar" está en Roboto Medium, color blanco y tamaño 18pt.
[Elemento 6] Separador Visual: Debajo del botón de ingresar, una línea horizontal delgada en color gris claro atraviesa la pantalla. En el centro de la línea, la palabra "O" en Roboto Regular y color gris medio crea una división lógica.
[Elemento 7] Botón de Inicio de Sesión con Google: Un botón de ancho completo con un estilo secundario. Tiene un fondo blanco, un borde gris claro y las mismas esquinas redondeadas que los demás elementos. A la izquierda, muestra el logo oficial de Google (la "G" de colores). El texto dice "Continuar con Google" y está en Roboto Medium, color gris oscuro.
[Elemento 8] Enlace Secundario - Recuperación: Ubicado en la parte inferior de la pantalla, debajo de todas las opciones de inicio de sesión. Es un enlace de texto que dice "¿Olvidaste tu contraseña?" en Roboto Regular y color azul corporativo.
Toque Final:
Palabras clave: Alta fidelidad, interfaz limpia, profesional, aplicación móvil (mobile UI), Google Sign-In button, diseño centrado, minimalista, UX intuitiva, tipografía Roboto, paleta de colores azul y gris.
Pantalla y Objetivo:
Pantalla: 2. Pantalla de Recuperación de Contraseña.
Objetivo: Proporcionar al usuario una interfaz simple y directa para iniciar el proceso de restablecimiento de su contraseña a través de su correo electrónico.
Estilo y Composición:
Estilo: Hereda la estética limpia, profesional y minimalista de la pantalla de Login. La interfaz está diseñada para eliminar toda distracción y centrar al usuario en una única acción.
Composición: Es una composición vertical y centrada. Un botón de "Regresar" en la parte superior izquierda rompe la simetría para ofrecer una ruta de escape clara. El resto de los elementos (título, texto, campo y botón) siguen un eje vertical central que guía la vista de forma natural.
Componentes Detallados:
[Elemento 1] Botón de Regreso: En la esquina superior izquierda, un icono de flecha hacia la izquierda (<) en color gris oscuro. Permite al usuario abandonar este flujo y volver a la pantalla de Login de forma intuitiva.
[Elemento 2] Título Principal: Centrado, debajo del botón de regreso. Un texto en Roboto Bold, tamaño 24pt y color gris oscuro, que dice: "Recuperar Contraseña".
[Elemento 3] Texto Instructivo: Debajo del título, un párrafo en Roboto Regular, tamaño 16pt y color gris medio, que explica la acción: "Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña."
[Elemento 4] Campo de Texto - Correo Electrónico: Un único campo de entrada, idéntico en estilo a los de la pantalla de Login (ancho completo, esquinas redondeadas, borde sutil, ícono de sobre). La etiqueta es "Correo Electrónico".
[Elemento 5] Botón Principal - "Enviar Enlace": Un botón de ancho completo en el azul corporativo primario. Ocupa la posición de acción principal en la parte inferior de la pantalla. El texto "Enviar Enlace de Recuperación" está en Roboto Medium, color blanco y tamaño 18pt.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, interfaz limpia, recuperación de contraseña, aplicación móvil (mobile UI), diseño centrado, UX simple, tipografía Roboto, iPhone 13 Pro frame, paleta de colores azul y gris.
Pantalla y Objetivo:
Pantalla: 3. Pantalla de Gestión de Perfil.
Objetivo: Ofrecer al usuario un espacio centralizado para visualizar su información personal, acceder a las opciones de gestión de su cuenta y cerrar la sesión de la aplicación.
Estilo y Composición:
Estilo: Consistente con el diseño limpio y profesional de la aplicación. El enfoque es la claridad y la legibilidad de la información, utilizando tarjetas y separadores para agrupar los elementos de forma lógica.
Composición: La pantalla tiene una composición de lista vertical, alineada en la parte superior. Un área de cabecera prominente para la identificación del usuario es seguida por secciones de opciones, creando un flujo de lectura natural de arriba hacia abajo.
Componentes Detallados:
[Elemento 1] Título de la Pantalla: En la parte superior, centrado, un texto en Roboto Bold, tamaño 22pt y color gris oscuro, que dice "Mi Perfil".
[Elemento 2] Avatar de Usuario: Debajo del título, un círculo grande (aprox. 96x96 píxeles) centrado. Contiene las iniciales del usuario (ej. "JP") en una tipografía Roboto Bold grande y de color blanco, sobre un fondo del azul corporativo.
[Elemento 3] Nombre y Rol: Centrados, debajo del avatar. El nombre completo del usuario (ej. "Juan Pérez") en Roboto Medium, tamaño 20pt, color gris oscuro. Justo debajo, su rol (ej. "Supervisor") en Roboto Regular, tamaño 16pt, color gris medio.
[Elemento 4] Tarjeta de Información: Una sección con un fondo gris muy claro y esquinas redondeadas. Contiene filas de información personal:
Fila 1 (Email): Un ícono de sobre a la izquierda, seguido del texto "Correo Electrónico" en Roboto Regular y debajo, la dirección de email del usuario en Roboto Medium.
Fila 2 (Sucursal): Un ícono de edificio a la izquierda, seguido del texto "Sucursal Principal" y debajo, el nombre de la sucursal del usuario en Roboto Medium.
[Elemento 5] Opción - Cambiar Contraseña: Debajo de la tarjeta de información, una fila interactiva de ancho completo. Contiene un ícono de llave a la izquierda, el texto "Cambiar Contraseña" en Roboto Regular y una flecha "chevron" (>) a la derecha para indicar que navega a otra pantalla.
[Elemento 6] Botón - Cerrar Sesión: Ubicado en la parte inferior de la pantalla, claramente separado del resto de las opciones. Es un botón de ancho completo con un estilo distintivo para acciones de salida: fondo blanco, borde de color rojo y el texto "Cerrar Sesión" en Roboto Medium y color rojo para alertar al usuario de que es una acción final.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, interfaz limpia, pantalla de perfil de usuario, avatar de usuario, ajustes de cuenta, aplicación móvil (mobile UI), diseño de listas, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 4. Pantalla de Cambio de Contraseña.
Objetivo: Proporcionar una interfaz segura y clara para que un usuario que ya ha iniciado sesión pueda actualizar su contraseña.
Estilo y Composición:
Estilo: Mantiene la coherencia visual con las pantallas anteriores, priorizando la simplicidad y la seguridad en un entorno limpio y profesional.
Composición: La estructura es un formulario vertical y centrado, muy similar a la pantalla de "Recuperar Contraseña" para mantener la familiaridad. Un botón de regreso permite al usuario cancelar la operación, y los campos se apilan lógicamente para culminar en un botón de acción principal en la parte inferior.
Componentes Detallados:
[Elemento 1] Botón de Regreso: Un icono de flecha hacia la izquierda (<) en la esquina superior izquierda, que devuelve al usuario a la "Pantalla de Gestión de Perfil".
[Elemento 2] Título Principal: Centrado, un texto en Roboto Bold, tamaño 24pt y color gris oscuro, que dice: "Cambiar Contraseña".
[Elemento 3] Campo de Texto - Contraseña Actual: Un campo de entrada de texto de ancho completo, con etiqueta "Contraseña Actual". Incluye el ícono de "ojo" para alternar la visibilidad. Este campo es crucial para verificar la identidad del usuario antes de permitir el cambio.
[Elemento 4] Campo de Texto - Nueva Contraseña: Un segundo campo de entrada con etiqueta "Nueva Contraseña", también con el ícono de visibilidad.
[Elemento 5] Campo de Texto - Confirmar Nueva Contraseña: Un tercer campo de entrada con etiqueta "Confirmar Nueva Contraseña" para asegurar que el usuario no cometa errores de tipeo.
[Elemento 6] Botón Principal - "Guardar Cambios": Un botón de ancho completo en el azul corporativo primario, ubicado en la parte inferior. El texto "Guardar Cambios" está en Roboto Medium, color blanco y tamaño 18pt.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, interfaz de seguridad, formulario de cambio de contraseña, aplicación móvil (mobile UI), diseño de formularios, UX segura, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 9. Pantalla de Inventario/Búsqueda.
Objetivo: Permitir a los usuarios visualizar la lista completa de activos, buscar ítems específicos, filtrar por sucursal y acceder a la función de añadir nuevos activos al inventario.
Estilo y Composición:
Estilo: El diseño es limpio, funcional y está optimizado para la visualización de datos en formato de lista. La jerarquía visual se centra en facilitar la búsqueda y la identificación rápida del estado de cada activo.
Composición: La pantalla se estructura con controles en la parte superior (título, selector de sucursal, búsqueda), un área de contenido principal para la lista desplazable de activos, y un botón de acción principal flotante en la esquina inferior derecha.
Componentes Detallados:
[Elemento 1] Título de la Pantalla: En la parte superior, alineado a la izquierda, un título prominente en Roboto Bold, tamaño 28pt, que dice "Inventario".
[Elemento 2] Selector de Sucursal: Debajo del título, un control de selección que muestra la sucursal actualmente visible (ej. "Colegio San José") con un pequeño ícono de "chevron" hacia abajo, indicando que se puede pulsar para cambiar de ubicación.
[Elemento 3] Barra de Búsqueda: Ocupando el ancho de la pantalla, debajo del selector. Es un campo de búsqueda con esquinas redondeadas, fondo gris claro, un ícono de lupa a la izquierda y un texto de marcador de posición "Buscar por nombre o código...".
[Elemento 4] Lista de Activos: El área principal de la pantalla. Es una lista vertical y desplazable compuesta por "Tarjetas de Activo". Si la lista está vacía, se mostrará un mensaje centrado (ej. "No hay activos en esta sucursal. Pulsa '+' para añadir el primero.").
[Elemento 5] Tarjeta de Activo (Componente): Cada ítem en la lista es una tarjeta interactiva con un borde sutil y esquinas redondeadas.
A la izquierda: Un espacio para una imagen en miniatura del activo o un icono genérico representativo.
En el centro: El nombre del activo en Roboto Medium, tamaño 16pt (ej. "Microscopio Óptico Avanzado"). Debajo, su código de identificación en Roboto Regular, tamaño 14pt y color gris (ej. "CÓDIGO: LAB-M-047").
A la derecha: Una "etiqueta de estado". Es una pequeña cápsula con fondo de color y texto. Verde con el texto "Disponible" o Naranja con el texto "Prestado".
[Elemento 6] Botón de Acción Flotante (FAB): Anclado en la esquina inferior derecha de la pantalla. Es un botón circular, de color azul corporativo intenso, con un ícono de "+" en color blanco en su interior. Este es el punto de entrada para añadir un nuevo activo al sistema.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, lista de inventario, barra de búsqueda, tarjeta de producto, etiqueta de estado, botón de acción flotante (FAB), UI de gestión, aplicación móvil, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 11. Pantalla de Formulario de Activo.
Objetivo: Proporcionar una interfaz de formulario estructurada y fácil de usar para que los operadores puedan registrar todos los detalles de un nuevo activo en el sistema.
Estilo y Composición:
Estilo: El diseño es limpio y se centra en la usabilidad del formulario. Se utilizan etiquetas claras, espaciado adecuado y una jerarquía visual que guía al usuario campo por campo para minimizar la carga cognitiva y los errores.
Composición: Una cabecera fija con acciones (Cancelar, Guardar) se sitúa en la parte superior. El cuerpo de la pantalla es una lista vertical desplazable de campos de entrada de datos.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un botón de texto o un ícono "X" que dice "Cancelar" para descartar los cambios y cerrar la pantalla.
En el centro: El título de la pantalla en Roboto Bold, "Nuevo Activo".
A la derecha: El botón de acción principal, "Guardar". Este botón estará visualmente desactivado (en gris claro) hasta que todos los campos obligatorios se completen, momento en el que se activará, cambiando al color azul corporativo.
[Elemento 2] Campo de Carga de Imagen: Una sección en la parte superior del formulario. Es un área cuadrada con un fondo gris muy claro y un ícono de cámara en el centro, con el texto "Añadir foto" debajo. Permite al usuario subir una imagen del activo.
[Elemento 3] Campo de Texto - Nombre del Activo: Un campo de texto estándar con la etiqueta "Nombre del Activo*" (el asterisco indica que es obligatorio).
[Elemento 4] Campo de Texto - Descripción: Un campo de texto más grande, de múltiples líneas, con la etiqueta "Descripción".
[Elemento 5] Grupo de Campos (Valor y Código): Dos campos de texto más pequeños uno al lado del otro para optimizar el espacio:
Campo Izquierdo: Etiqueta "Valor (USD)*". Es un campo numérico.
Campo Derecho: Etiqueta "Código / SKU". Para un identificador interno.
[Elemento 6] Selector - Sucursal Base: Una fila interactiva con la etiqueta "Sucursal Base*". Muestra la sucursal seleccionada y una flecha "chevron" (>) a la derecha, indicando que al pulsarla se abrirá una lista de sucursales para elegir.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, formulario de entrada de datos, UI de formulario, crear nuevo ítem, campos de texto, aplicación móvil, diseño limpio, UX funcional, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 12. Pantalla de Generación de QR.
Objetivo: Mostrar de forma clara y grande el código QR único generado para el nuevo activo, y ofrecer al usuario acciones sencillas para guardarlo o compartirlo con el fin de imprimirlo.
Estilo y Composición:
Estilo: El diseño es utilitario y minimalista. Toda la atención se dirige al código QR, eliminando cualquier distracción. La interfaz es limpia y se enfoca en la acción inmediata.
Composición: La pantalla está dominada por el código QR en el centro. Los textos y botones de acción se disponen verticalmente alrededor de este elemento principal para una máxima claridad.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
En el centro: Un texto de confirmación en Roboto Medium, tamaño 18pt, que dice "Activo Creado con Éxito".
A la derecha: Un botón de texto prominente que dice "Hecho" en el color azul corporativo. Al pulsarlo, el usuario vuelve a la pantalla de Inventario.
[Elemento 2] Código QR: El elemento principal de la pantalla. Un código QR grande, nítido y de alto contraste (negro sobre fondo blanco), ubicado en el centro de la pantalla.
[Elemento 3] Identificador del Activo: Justo debajo del código QR, se muestra el nombre y el código del activo correspondiente para evitar confusiones al imprimir.
Línea 1: Nombre del activo en Roboto Bold (ej. "Microscopio Óptico Avanzado").
Línea 2: Código del activo en Roboto Regular y color gris (ej. "CÓDIGO: LAB-M-047").
[Elemento 4] Botones de Acción: Debajo del identificador, dos botones de acción con un estilo secundario (fondo blanco, borde y texto en azul corporativo), uno al lado del otro.
Botón Izquierdo: Con un ícono de descarga, el texto "Guardar Imagen". Guarda el QR en la galería del teléfono.
Botón Derecho: Con un ícono de compartir, el texto "Compartir". Abre el menú nativo del sistema operativo para enviar la imagen.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, pantalla de código QR, generación de QR, interfaz minimalista, UI de utilidad, íconos claros, aplicación móvil, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 10. Pantalla de Detalle del Activo (Estado: Disponible).
Objetivo: Presentar toda la información relevante de un activo específico y ofrecer las acciones principales que se pueden realizar con él, como iniciar un préstamo.
Estilo y Composición:
Estilo: El diseño es informativo y claro, enfocado en presentar los datos de forma rápida y legible. Utiliza una jerarquía visual fuerte para distinguir la información clave (como el estado) de los detalles secundarios.
Composición: La pantalla se organiza de arriba hacia abajo: una cabecera de navegación, una imagen grande del producto para confirmación visual, un panel de estado destacado, una lista de detalles y un botón de acción principal anclado en la parte inferior.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para regresar a la lista de Inventario.
En el centro: El nombre del activo como título (ej. "Microscopio Óptico") en Roboto Bold.
A la derecha: Un icono de "más opciones" (tres puntos verticales) que, al pulsarlo, desplegará un menú con acciones secundarias como "Editar", "Trasladar" y "Dar de Baja".
[Elemento 2] Imagen del Activo: Un área grande y prominente debajo de la cabecera que muestra la foto del activo. Si no hay foto, muestra un icono genérico.
[Elemento 3] Panel de Estado: Justo debajo de la imagen, una sección que contiene:
El código del activo en Roboto Regular (ej. "CÓDIGO: LAB-M-047").
Al lado, una etiqueta de estado grande y muy visible: una cápsula con fondo verde intenso y el texto "Disponible" en Roboto Medium y color blanco.
[Elemento 4] Lista de Detalles: Una serie de filas que presentan la información del activo:
Fila 1 (Valor): Icono de dólar, etiqueta "Valor", y el monto en Roboto Medium.
Fila 2 (Sucursal): Icono de ubicación, etiqueta "Sucursal Base", y el nombre del colegio en Roboto Medium.
Fila 3 (Descripción): Un área con la descripción detallada del activo.
[Elemento 5] Botón de Acción Principal: Anclado en la parte inferior de la pantalla para fácil acceso. Es un botón de ancho completo, en el color azul corporativo principal. El texto dice "Iniciar Préstamo" en Roboto Medium y color blanco.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, detalle de producto, UI de gestión, estado disponible, aplicación móvil, interfaz limpia, botón de acción, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 10. Pantalla de Detalle del Activo (Estado: Prestado).
Objetivo: Informar claramente al usuario que el activo no está disponible, mostrando quién es el responsable del préstamo y cuándo debe ser devuelto. La acción principal es facilitar el registro de la devolución.
Estilo y Composición:
Estilo: El diseño mantiene la consistencia visual con la pantalla anterior, pero utiliza el color para comunicar un cambio de estado inmediato. La información del préstamo se convierte en el foco principal.
Composición: La estructura general (cabecera, imagen, botón inferior) es idéntica para mantener la familiaridad. Sin embargo, la sección de detalles se reemplaza por una "tarjeta de préstamo" dedicada, y el botón de acción principal cambia su función y texto.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla: Se mantiene idéntica, con la flecha de regreso, el nombre del activo como título y el icono de "más opciones".
[Elemento 2] Imagen del Activo: Se mantiene la misma imagen grande y prominente del activo.
[Elemento 3] Panel de Estado: El cambio principal es la etiqueta de estado:
El código del activo se mantiene (ej. "CÓDIGO: LAB-M-047").
La etiqueta ahora es de color naranja/ámbar y el texto dice "Prestado" en Roboto Medium y color blanco.
[Elemento 4] Tarjeta de Información del Préstamo: La lista de detalles se sustituye por una tarjeta destacada que contiene la información del préstamo actual:
Fila 1 (Responsable): Icono de usuario, etiqueta "Prestado a", y el nombre del responsable en Roboto Medium.
Fila 2 (Fecha de Devolución): Icono de calendario, etiqueta "Fecha de Devolución", y la fecha límite. Si la fecha ya ha pasado (préstamo vencido), el texto de la fecha se mostrará en color rojo para indicar urgencia.
[Elemento 5] Botón de Acción Principal: Anclado en la parte inferior, mantiene el fondo azul corporativo, pero su función cambia por completo:
El texto ahora dice "Registrar Devolución" en Roboto Medium y color blanco.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, detalle de producto, estado en préstamo, UI de gestión, aplicación móvil, interfaz limpia, tarjeta de información, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 17. Pantalla de Iniciar Préstamo (Selección de Responsable).
Objetivo: Permitir al operador buscar y seleccionar de forma rápida y eficiente a la persona (tanto personal interno como contactos externos) que se hará responsable del préstamo del activo.
Estilo y Composición:
Estilo: Es una pantalla de utilidad, diseñada para la velocidad. El diseño es limpio, con un fuerte énfasis en la funcionalidad de búsqueda y la claridad de la lista de resultados.
Composición: La pantalla se compone de una cabecera fija con el título y una acción de regreso, una barra de búsqueda prominente (que puede estar anclada a la cabecera), y una lista desplazable de contactos que ocupa el resto del espacio.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para cancelar la operación y volver a la pantalla de "Detalle del Activo".
En el centro: El título de la pantalla, "Seleccionar Responsable", en Roboto Bold.
[Elemento 2] Barra de Búsqueda: Debajo de la cabecera, una barra de búsqueda de ancho completo con esquinas redondeadas y fondo gris claro. Contiene un icono de lupa y el texto de marcador de posición "Buscar por nombre...".
[Elemento 3] Lista de Contactos: Una lista vertical y desplazable de personas. Para agilizar el proceso, la lista podría mostrar inicialmente los "Contactos Recientes".
[Elemento 4] Tarjeta de Contacto (Componente): Cada persona en la lista se representa en una fila interactiva.
A la izquierda: Un avatar circular con las iniciales del contacto (ej. "AP") sobre un fondo de color suave.
En el centro: El nombre completo del contacto en Roboto Medium (ej. "Ana Pérez"). Debajo, en una línea secundaria con Roboto Regular y color gris, se muestra su rol o institución (ej. "Asistente de Laboratorio" o "Colegio San Carlos").
[Elemento 5] Botón de Acción Secundario: Al final de la lista, un botón de texto claro, "+ Añadir Nuevo Contacto Externo", que permitiría al operador registrar a una persona que no se encuentra en el sistema sin tener que abandonar el flujo de préstamo.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, UI de búsqueda, lista de selección de usuario, aplicación móvil, interfaz limpia, selección de contacto, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 18. Pantalla de Confirmación de Préstamo.
Objetivo: Presentar al operador un resumen claro y conciso de toda la información del préstamo (activo, responsable y fechas) para una última verificación antes de registrarlo oficialmente en el sistema.
Estilo y Composición:
Estilo: El diseño es limpio y se enfoca en la presentación de información para confirmación. No hay elementos de distracción. La tipografía y los componentes visuales se utilizan para crear una jerarquía clara entre el "qué", el "quién" y el "cuándo".
Composición: La pantalla se estructura como un resumen vertical. Una cabecera de navegación, seguida por tarjetas informativas para el activo y el responsable, un selector de fecha y, finalmente, el botón de confirmación definitivo anclado en la parte inferior.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para volver a la pantalla anterior y cambiar al responsable si es necesario.
En el centro: El título de la pantalla, "Confirmar Préstamo", en Roboto Bold.
[Elemento 2] Tarjeta-Resumen del Activo: Una tarjeta visual en la parte superior que identifica el ítem. Muestra la imagen en miniatura del activo, su nombre ("Microscopio Óptico Avanzado") y su código ("LAB-M-047").
[Elemento 3] Tarjeta-Resumen del Responsable: Debajo de la del activo, una segunda tarjeta que identifica a la persona seleccionada. Muestra su avatar con iniciales, su nombre completo y su rol o institución.
[Elemento 4] Selector de Fecha de Devolución: Una sección interactiva con la etiqueta "Fecha de Devolución*". Muestra una fecha por defecto (ej. 7 días a partir de hoy, 22 de agosto de 2025) y un icono de calendario. Al pulsar esta sección, se abriría un selector de fecha nativo del sistema operativo.
[Elemento 5] Botón de Acción Principal: Anclado en la parte inferior de la pantalla. Es un botón de ancho completo en el color azul corporativo principal. El texto es inequívoco: "Confirmar y Registrar Préstamo" en Roboto Medium y color blanco.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, pantalla de resumen, confirmación de préstamo, UI de transacción, aplicación móvil, interfaz limpia, tarjetas de información, selector de fecha, tipografía Roboto, iPhone 13 Pro frame.
Plantilla de Descripción de Diseño
Pantalla y Objetivo:
Pantalla: 13. Modal de Éxito/Confirmación.
Objetivo: Informar al usuario de manera visual y concisa que una acción importante (como registrar un préstamo) se ha completado correctamente, y guiarlo de vuelta a la pantalla principal.
Estilo y Composición:
Estilo: El diseño es extremadamente minimalista y centrado. Utiliza iconografía y color para comunicar el éxito de forma instantánea, sin necesidad de leer mucho texto.
Composición: Es un modal (una pequeña ventana superpuesta) que aparece en el centro de la pantalla, sobre un fondo semitransparente que desenfoca la pantalla anterior. Todos los elementos dentro del modal están centrados verticalmente para un máximo impacto y claridad.
Componentes Detallados:
[Elemento 1] Fondo Superpuesto: La pantalla anterior (Confirmación de Préstamo) se oscurece con una capa de color negro con un 70% de opacidad para dirigir toda la atención al modal.
[Elemento 2] Contenedor del Modal: Un recuadro con esquinas muy redondeadas y fondo blanco que flota en el centro.
[Elemento 3] Icono de Éxito: El elemento más prominente dentro del modal. Un círculo grande de color verde con un icono de "check" (✓) grande y de color blanco en su interior. Este es el principal comunicador visual del éxito.
[Elemento 4] Título de Confirmación: Debajo del icono, un texto en Roboto Bold, tamaño 20pt y color gris oscuro, que dice "Préstamo Registrado".
[Elemento 5] Botón - "Entendido": Debajo del título, un único botón de ancho completo (dentro del modal) en el color azul corporativo. El texto dice "Entendido" en Roboto Medium y color blanco. Al pulsarlo, el modal se cierra y la aplicación navega al Dashboard principal.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, modal de éxito, UI de confirmación, pop-up, icono de check, aplicación móvil, UX limpia, minimalista, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 13. Pantalla de Gestión de Contenedores.
Objetivo: Ofrecer al usuario un lugar centralizado para ver todos los contenedores (cajas, estantes) de su sucursal, y desde aquí, iniciar el flujo para crear uno nuevo.
Estilo y Composición:
Estilo: El diseño es coherente con la pantalla de "Inventario", utilizando un formato de lista claro y funcional para mantener la familiaridad del usuario. La prioridad es la fácil identificación y el acceso rápido a las acciones.
Composición: Una cabecera de navegación estándar, un cuerpo principal compuesto por una lista desplazable de tarjetas de contenedor, y un Botón de Acción Flotante (FAB) para la creación de nuevos elementos.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para regresar a la pantalla principal de Inventario.
En el centro: El título de la pantalla, "Gestionar Contenedores", en Roboto Bold.
[Elemento 2] Lista de Contenedores: El área principal de la pantalla. Es una lista vertical de "Tarjetas de Contenedor". Si no existe ninguno, mostrará un mensaje ilustrativo para guiar al usuario.
[Elemento 3] Tarjeta de Contenedor (Componente): Cada contenedor en la lista es una tarjeta interactiva.
A la izquierda: Un icono representativo, como una caja abierta o un estante, para diferenciarlo visualmente de un activo normal.
En el centro: El nombre del contenedor en Roboto Medium (ej. "Caja de Microscopios Portátiles"). Debajo, en Roboto Regular y color gris, un resumen de su contenido (ej. "Contiene: 5 activos").
A la derecha: Un icono de "chevron" (>) para indicar que al pulsar la tarjeta se navegará a la vista de su contenido.
[Elemento 4] Botón de Acción Flotante (FAB): Idéntico al de la pantalla de Inventario. Anclado en la esquina inferior derecha, es un botón circular de color azul corporativo con un ícono de "+" en blanco. Su función aquí es iniciar la creación de un nuevo contenedor.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, UI de gestión, lista de contenedores, inventario jerárquico, aplicación móvil, Botón de Acción Flotante (FAB), diseño de listas, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 14. Pantalla de Vista de Contenido de un Contenedor.
Objetivo: Mostrar al usuario una lista clara de todos los activos que están asignados a un contenedor específico, permitiéndole ver el estado de cada uno y seleccionarlos para realizar acciones individuales.
Estilo y Composición:
Estilo: El diseño es informativo y coherente con las pantallas de listas anteriores. La composición está pensada para identificar primero el contenedor y luego explorar su contenido de forma intuitiva.
Composición: Una cabecera de navegación clara, seguida de un pequeño panel que resume los datos del contenedor. El resto de la pantalla está dedicado a una lista desplazable de los activos que contiene.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para regresar a la lista de "Gestionar Contenedores".
En el centro: El nombre del contenedor como título (ej. "Caja de Microscopios") en Roboto Bold.
A la derecha: Un icono de "más opciones" (tres puntos) para acciones relacionadas con el contenedor en sí (ej. "Editar Nombre", "Imprimir QR").
[Elemento 2] Panel de Información del Contenedor: Una pequeña área no interactiva debajo de la cabecera que muestra detalles del contenedor:
Ubicación: "Ubicación: Estante B-04"
Resumen: "Contenido: 5 activos"
[Elemento 3] Lista de Activos Asignados: El cuerpo principal de la pantalla. Es una lista vertical que utiliza el mismo componente "Tarjeta de Activo" que diseñamos para la pantalla de Inventario, garantizando consistencia.
[Elemento 4] Tarjeta de Activo (Componente Reutilizado): Cada ítem en la lista es una tarjeta interactiva que muestra:
Miniatura o icono del activo.
Nombre del activo y su código.
La etiqueta de estado correspondiente: Verde ("Disponible") o Naranja ("Prestado"). Esto es crucial para saber si se puede tomar un ítem de la caja o si ya está en uso por otra persona.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, vista de contenido, lista de activos, inventario jerárquico, UI de gestión, aplicación móvil, tarjeta de producto, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 15. Interfaz de Asignación Rápida por QR.
Objetivo: Permitir al operador asignar múltiples activos a un contenedor de forma secuencial y rápida, utilizando la cámara para escanear primero el contenedor y luego cada uno de los activos que se guardarán en él.
Estilo y Composición:
Estilo: El diseño es puramente funcional y se centra en la tarea. Utiliza instrucciones claras y un área de visualización de cámara grande para hacer que el proceso de escaneo sea lo más simple posible.
Composición: La pantalla está dividida en dos secciones principales: una sección superior de "estado/instrucción" que guía al usuario, y una sección inferior que muestra la vista de la cámara activa.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un botón de texto "Finalizar" en color azul corporativo. Permite al usuario terminar el proceso de asignación en cualquier momento y volver a la pantalla anterior.
En el centro: El título de la pantalla, "Asignación Rápida", en Roboto Bold.
[Elemento 2] Panel de Instrucciones: Un panel fijo en la parte superior, debajo de la cabecera. Este panel cambia dinámicamente para guiar al usuario en dos pasos:
Paso 1 (Estado Inicial): Muestra un icono grande de un contenedor y el texto instructivo en Roboto Medium: "Paso 1: Escanee el QR del CONTENEDOR".
Paso 2 (Después de escanear el contenedor): El panel se actualiza. Ahora muestra el nombre del contenedor escaneado (ej. "Caja de Microscopios") y la nueva instrucción: "Paso 2: Escanee el QR de los ACTIVOS".
[Elemento 3] Vista de la Cámara: La mayor parte de la pantalla está ocupada por la vista en vivo de la cámara del dispositivo, con un recuadro o guía visual en el centro para ayudar al usuario a alinear los códigos QR.
[Elemento 4] Feedback de Escaneo: Cuando un activo es escaneado con éxito en el Paso 2, la pantalla proporciona una retroalimentación instantánea:
Un breve destello verde en la pantalla.
Una pequeña notificación temporal (toast) aparece en la parte inferior con el texto "✅ [Nombre del Activo] añadido a la caja".
La cámara permanece activa, lista para escanear el siguiente activo sin interrupciones.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, interfaz de escáner, asignación por lotes, UI de cámara, UX rápida, aplicación móvil, flujo de trabajo operativo, tipografía Roboto, iPhone 13 Pro frame.
Plantilla de Descripción de Diseño
Pantalla y Objetivo:
Pantalla: 7. Dashboard del Supervisor.
Objetivo: Ofrecer a los supervisores una vista consolidada y de alto nivel de los indicadores clave (KPIs) del inventario, permitiéndoles evaluar rápidamente la salud del sistema y detectar problemas urgentes como los préstamos vencidos.
Estilo y Composición:
Estilo: El diseño es un dashboard moderno, centrado en la visualización de datos de forma clara y digerible. Utiliza un sistema de tarjetas para segmentar la información y colores de acento para llamar la atención sobre las métricas más críticas.
Composición: Una cabecera de bienvenida, seguida por el filtro principal de sucursal. El cuerpo principal se organiza con las tarjetas de KPIs más importantes en la parte superior, seguidas de un resumen de la actividad reciente.
Componentes Detallados:
[Elemento 1] Cabecera de Bienvenida:
A la izquierda, un saludo personalizado: "Hola, Juan" en Roboto Bold, tamaño 24pt. Debajo, en gris y Roboto Regular: "Aquí está el resumen de hoy."
A la derecha, el avatar del usuario, que funciona como atajo a la pantalla de perfil.
[Elemento 2] Selector de Sucursal: Debajo de la cabecera, un selector prominente para filtrar los datos de todo el dashboard, mostrando "Consolidado General" o un nombre de sucursal específico.
[Elemento 3] Tarjetas de KPIs Principales: Una fila de tres tarjetas interactivas que muestran las métricas más importantes:
Tarjeta 1 (Valor Total): Título "Valor del Inventario". Muestra el monto total en grande (ej. "$85,320.00") en Roboto Medium.
Tarjeta 2 (Activos Prestados): Título "Activos Prestados". Muestra el número total (ej. "42") en grande.
Tarjeta 3 (Préstamos Vencidos): Título "Préstamos Vencidos". Muestra el número (ej. "8"). Esta tarjeta tiene un borde y un texto en color rojo para señalar urgencia y atraer la atención inmediata.
[Elemento 4] Tarjeta de Actividad Reciente: Una tarjeta más grande que ocupa el resto del espacio visible. Contiene una lista desplazable de los últimos movimientos registrados (préstamos, devoluciones, nuevos activos), cada uno con un icono, una breve descripción y la hora del evento.
[Elemento 5] Barra de Pestañas de Navegación: El componente de navegación principal en la parte inferior de la pantalla, con la pestaña "Dashboard" marcada como activa.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, dashboard de supervisor, tarjetas de KPI, visualización de datos, UI de gestión, aplicación móvil, interfaz limpia, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 21. Pantalla de Reporte de Préstamos.
Objetivo: Ofrecer una lista detallada y procesable de todos los préstamos, permitiendo a los supervisores filtrar por estado (especialmente los vencidos) y tomar acciones directas como enviar recordatorios.
Estilo y Composición:
Estilo: El diseño es el de una lista de datos, optimizada para la legibilidad y la identificación rápida de información crítica. El color se utiliza de forma estratégica para resaltar los elementos que requieren atención inmediata.
Composición: Una cabecera de navegación, seguida por pestañas de filtro rápido para cambiar entre diferentes vistas de la lista. El cuerpo principal es una lista desplazable de tarjetas, cada una resumiendo un préstamo.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para regresar al Dashboard.
En el centro: El título de la pantalla, "Reporte de Préstamos", en Roboto Bold.
[Elemento 2] Pestañas de Filtro: Debajo de la cabecera, un conjunto de pestañas para filtrar la lista. Por ejemplo: "Activos", "Vencidos", "Historial". La pestaña "Vencidos" estaría seleccionada y resaltada con una línea inferior de color rojo.
[Elemento 3] Lista de Préstamos Vencidos: El área principal de la pantalla, que muestra una lista de todos los préstamos que han superado su fecha de devolución.
[Elemento 4] Tarjeta de Préstamo Vencido (Componente): Cada ítem en la lista es una tarjeta con información clave:
Línea 1: El nombre del activo en Roboto Medium (ej. "Kit de Herramientas de Precisión").
Línea 2: El nombre del responsable en Roboto Regular (ej. "Prestado a: Carlos Valiente").
A la derecha: La fecha de devolución, destacada en Roboto Bold y color rojo para indicar el estado de vencimiento (ej. "Venció: 10 ago. 2025").
Botón de Acción: Debajo de la información, un botón con el texto "Enviar Recordatorio" y un pequeño icono de WhatsApp, permitiendo al supervisor iniciar el flujo de notificación directamente desde la lista.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, pantalla de reporte, lista de datos, préstamos vencidos, UI de gestión, filtros de estado, aplicación móvil, alerta en color, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 22. Pantalla de Modo Auditoría.
Objetivo: Ofrecer al supervisor una herramienta interactiva para realizar un inventario físico. Le permite escanear todos los activos de una sucursal y comparar la lista física con la digital, identificando discrepancias al instante.
Estilo y Composición:
Estilo: El diseño es el de una herramienta de productividad, enfocado en la tarea. Es limpio, claro y proporciona retroalimentación visual inmediata sobre el progreso de la auditoría.
Composición: Una cabecera informativa, un panel de progreso destacado en la parte superior, una lista de activos a modo de checklist, y un botón de acción principal para escanear.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un botón de texto "Finalizar Auditoría" que, al pulsarlo, mostraría un resumen y daría por terminado el proceso.
En el centro: El título de la pantalla, "Auditoría: Colegio San José", en Roboto Bold.
[Elemento 2] Panel de Progreso: Debajo de la cabecera, una tarjeta que muestra el estado de la auditoría en tiempo real.
Incluye una barra de progreso visual.
Muestra contadores clave: "Verificados: 25 / 150", "Faltantes: 125".
[Elemento 3] Lista de Activos por Verificar: El cuerpo de la pantalla es una lista de todos los activos registrados en esa sucursal.
[Elemento 4] Tarjeta de Activo de Auditoría (Componente): Cada ítem de la lista representa un activo a encontrar.
A la izquierda: Un círculo. Inicialmente es un círculo vacío de color gris. Cuando el activo se escanea y se verifica, el círculo se vuelve verde y muestra un icono de check (✓).
En el centro: El nombre y el código del activo.
[Elemento 5] Botón Principal - "Escanear": Un botón de ancho completo anclado en la parte inferior de la pantalla, o un Botón de Acción Flotante (FAB) grande. Tiene un icono de cámara y el texto "Escanear Activo". Al pulsarlo, se activa la interfaz de la cámara para buscar y verificar el siguiente ítem.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, UI de auditoría, checklist de inventario, escáner de activos, barra de progreso, aplicación móvil de productividad, diseño funcional, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 3. Pantalla de Onboarding (Vista 1 de 3).
Objetivo: Dar la bienvenida al nuevo usuario e introducir la funcionalidad principal de la aplicación: la identificación instantánea de activos mediante el escaneo de códigos QR.
Estilo y Composición:
Estilo: El diseño es amigable, visual y minimalista. El foco principal es una gran ilustración que comunica el concepto de forma rápida, complementada por un texto mínimo y claro.
Composición: La pantalla está perfectamente centrada. Una gran ilustración ocupa la mitad superior, seguida por el texto y los indicadores de página en la mitad inferior, creando un balance visual simple y agradable.
Componentes Detallados:
[Elemento 1] Botón "Saltar": En la esquina superior derecha, un botón de texto simple que dice "Saltar" en el color azul corporativo. Permite a los usuarios avanzados omitir el tutorial.
[Elemento 2] Ilustración Principal: Una ilustración grande, de estilo "flat design" moderno y limpio. Muestra una mano sosteniendo un smartphone, apuntando su cámara hacia un código QR pegado en un equipo de laboratorio (como un microscopio). La ilustración utiliza la paleta de colores de la marca.
[Elemento 3] Título Principal: Debajo de la ilustración, un título en Roboto Bold, tamaño 24pt, centrado y en color gris oscuro, que dice: "Todo a la Mano".
[Elemento 4] Texto Descriptivo: Debajo del título, un texto breve en Roboto Regular, tamaño 16pt, centrado y en color gris medio: "Escanea el código QR de cualquier activo para ver su estado y ubicación al instante."
[Elemento 5] Indicador de Página: En la parte inferior de la pantalla, un conjunto de tres puntos (bullets) para indicar el progreso. El primer punto está relleno con el color azul corporativo, mientras que los otros dos son contornos de color gris, mostrando que esta es la página 1 de 3.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, pantalla de onboarding, bienvenida, UI de tutorial, ilustración flat design, aplicación móvil, amigable, minimalista, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 3. Pantalla de Onboarding (Vista 2 de 3).
Objetivo: Introducir la funcionalidad de registrar préstamos, comunicando al usuario que la aplicación le dará control y trazabilidad sobre quién tiene cada activo.
Estilo y Composición:
Estilo: El diseño mantiene la estética amigable, visual y minimalista de la pantalla anterior. La ilustración sigue siendo el foco principal para comunicar el concepto de forma rápida.
Composición: La pantalla sigue la misma estructura centrada: ilustración en la mitad superior, seguida por el texto y los indicadores de página en la mitad inferior, garantizando la consistencia visual del flujo de onboarding.
Componentes Detallados:
[Elemento 1] Botón "Saltar": Se mantiene en la esquina superior derecha, permitiendo al usuario omitir el tutorial en cualquier momento.
[Elemento 2] Ilustración Principal: Una ilustración grande, de estilo "flat design". Muestra una herramienta (ej. un taladro o equipo de laboratorio) pasando simbólicamente de una mano a otra. La mano que recibe la herramienta tiene un "check" (✓) verde sobre ella, representando una transacción exitosa y responsable.
[Elemento 3] Título Principal: Debajo de la ilustración, un título en Roboto Bold, tamaño 24pt, centrado, que dice: "Préstamos Responsables".
[Elemento 4] Texto Descriptivo: Debajo del título, un texto breve en Roboto Regular, tamaño 16pt, centrado y en color gris medio: "Registra préstamos en segundos y mantén un control claro de quién tiene cada herramienta."
[Elemento 5] Indicador de Página: En la parte inferior, el conjunto de tres puntos. Ahora, el segundo punto está relleno con el color azul corporativo, mientras que el primero y el tercero son contornos grises, indicando que estamos en la página 2 de 3.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, pantalla de onboarding, ilustración de préstamo, UI de tutorial, aplicación móvil, amigable, minimalista, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 3. Pantalla de Onboarding (Vista 3 de 3).
Objetivo: Presentar la funcionalidad de los contenedores, mostrando al usuario cómo puede organizar grupos de activos para saber qué hay en una caja o estante de un solo vistazo.
Estilo y Composición:
Estilo: Coherente con las pantallas anteriores: amigable, visual y minimalista, con una ilustración como foco principal.
Composición: Mantiene la estructura centrada de ilustración, texto e indicadores de página para cerrar el flujo de onboarding de manera consistente.
Componentes Detallados:
[Elemento 1] Botón "Saltar": Se mantiene en la esquina superior derecha.
[Elemento 2] Ilustración Principal: Una ilustración grande de estilo "flat design". Muestra un ícono grande de una caja de cartón abierta o un estante de laboratorio. Dentro del ícono, se ven siluetas o versiones más pequeñas de varios activos (un microscopio, herramientas, etc.), representando visualmente el concepto de agrupar ítems.
[Elemento 3] Título Principal: Debajo de la ilustración, un título en Roboto Bold, tamaño 24pt, centrado, que dice: "Organización Eficiente".
[Elemento 4] Texto Descriptivo: Debajo del título, un texto breve en Roboto Regular, tamaño 16pt, centrado y en color gris medio: "Agrupa activos en contenedores para saber qué hay en cada caja o estante sin abrirlos."
[Elemento 5] Indicador de Página: En la parte inferior, el conjunto de tres puntos. Ahora, el tercer y último punto está relleno con el color azul corporativo.
[Elemento 6] Botón de Acción Principal: Debajo de los puntos de paginación, reemplazando el texto "Siguiente" de las pantallas anteriores, aparece un botón de ancho completo en el azul corporativo. El texto dice "¡Entendido, a Trabajar!" en Roboto Medium y color blanco, indicando el final del tutorial.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, pantalla de onboarding, ilustración de organización, UI de tutorial, aplicación móvil, amigable, minimalista, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 24. Pantalla de Administración.
Objetivo: Servir como un menú visualmente atractivo y claro para los "Administradores", guiándolos a las secciones de gestión a través de dos grandes botones interactivos.
Estilo y Composición:
Estilo: El diseño evoluciona de una simple lista a un layout de tarjetas grandes y audaces. Es moderno, espacioso y utiliza la iconografía y el tamaño para crear una experiencia de navegación más táctil y visual.
Composición: Una cabecera simple en la parte superior. El cuerpo de la pantalla está dominado por dos grandes tarjetas rectangulares apiladas verticalmente, con un espacio de separación entre ellas. Cada tarjeta funciona como un gran botón.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para regresar.
En el centro: El título de la pantalla, "Administración", en Roboto Bold.
[Elemento 2] Tarjeta de Gestión de Usuarios: La primera tarjeta grande, que ocupa casi todo el ancho de la pantalla. Tiene un fondo gris muy claro y esquinas redondeadas. Dentro de la tarjeta:
Icono Grande: Un icono prominente de un grupo de personas en el color azul corporativo.
Título: Debajo del icono, el texto "Gestionar Usuarios" en Roboto Medium, tamaño 18pt.
Descripción Corta: Debajo del título, un texto más pequeño en Roboto Regular y color gris: "Crear cuentas y asignar roles".
[Elemento 3] Tarjeta de Gestión de Contactos: La segunda tarjeta grande, idéntica en estilo a la primera y ubicada debajo de ella.
Icono Grande: Un icono prominente de una libreta de contactos en el color azul corporativo.
Título: Debajo del icono, el texto "Gestionar Contactos Externos" en Roboto Medium, tamaño 18pt.
Descripción Corta: Debajo del título, un texto más pequeño: "Administrar la base de datos de personal externo".
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, panel de administración, menú de tarjetas, UI de gestión, botones grandes, aplicación móvil, diseño moderno, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 25. Pantalla de Lista de Usuarios.
Objetivo: Mostrar al administrador una lista completa de todos los usuarios registrados en el sistema, permitiéndole ver su información clave (como el rol) de un vistazo, buscar usuarios específicos, y acceder a la función para crear una nueva cuenta.
Estilo y Composición:
Estilo: El diseño es una lista de datos limpia y funcional, coherente con las otras pantallas de listas de la aplicación para mantener una experiencia de usuario consistente.
Composición: Una cabecera de navegación, una barra de búsqueda para filtrado rápido, el cuerpo principal con la lista de usuarios, y un Botón de Acción Flotante (FAB) para añadir nuevas cuentas.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para regresar al menú de Administración.
En el centro: El título de la pantalla, "Gestionar Usuarios", en Roboto Bold.
[Elemento 2] Barra de Búsqueda: Debajo de la cabecera, una barra de búsqueda para que el administrador pueda encontrar rápidamente a un usuario por su nombre.
[Elemento 3] Lista de Usuarios: El área principal de la pantalla, que muestra una lista vertical y desplazable de todos los usuarios registrados.
[Elemento 4] Tarjeta de Usuario (Componente): Cada usuario en la lista es una tarjeta interactiva.
A la izquierda: Un avatar circular con las iniciales del usuario.
En el centro: El nombre completo del usuario en Roboto Medium. Debajo, su correo electrónico en Roboto Regular y color gris.
A la derecha: Una "etiqueta de rol" para identificar rápidamente sus permisos. Por ejemplo, una etiqueta azul para "Supervisor" y una etiqueta gris para "Operador".
[Elemento 5] Botón de Acción Flotante (FAB): Anclado en la esquina inferior derecha. Es un botón circular de color azul corporativo con un ícono de "+" en blanco para iniciar el flujo de creación de un nuevo usuario.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, lista de usuarios, gestión de usuarios, UI de administración, tarjeta de perfil, etiqueta de rol, aplicación móvil, Botón de Acción Flotante (FAB), tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 26. Formulario de Creación/Edición de Usuario.
Objetivo: Proporcionar al administrador un formulario claro y seguro para registrar un nuevo usuario en el sistema, definiendo su información personal, rol (permisos) y sucursal de trabajo.
Estilo y Composición:
Estilo: Un diseño de formulario limpio y funcional, consistente con los otros formularios de la aplicación para una experiencia predecible. El foco está en la claridad de las etiquetas y la facilidad de entrada de datos.
Composición: Una cabecera fija con las acciones de cancelar y guardar. El cuerpo de la pantalla es una lista vertical de campos de texto y selectores necesarios para la creación de la cuenta.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un botón de texto "Cancelar" para descartar la creación y volver a la lista.
En el centro: El título de la pantalla, "Crear Nuevo Usuario", en Roboto Bold.
A la derecha: Un botón de texto "Guardar", que permanece desactivado (en gris) hasta que todos los campos obligatorios estén completos.
[Elemento 2] Campo de Texto - Nombre Completo: Un campo de entrada de texto estándar con la etiqueta "Nombre Completo*".
[Elemento 3] Campo de Texto - Correo Electrónico: Un campo de entrada de texto para el email del usuario (que servirá como su nombre de usuario para el login), con la etiqueta "Correo Electrónico*".
[Elemento 4] Campo de Texto - Contraseña Temporal: Un campo de contraseña con el icono de "ojo" para alternar la visibilidad. La etiqueta es "Contraseña Temporal*".
[Elemento 5] Selector de Rol: Una fila interactiva crucial con la etiqueta "Rol*". Al pulsarla, se despliega un menú para seleccionar entre "Operador" y "Supervisor".
[Elemento 6] Selector de Sucursal: Otra fila interactiva con la etiqueta "Sucursal Base*". Permite al administrador asignar el nuevo usuario a un laboratorio o colegio específico.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, formulario de creación de usuario, UI de administración, campos de texto, selector de rol, gestión de cuentas, aplicación móvil, tipografía Roboto, iPhone 13 Pro frame.
Pantalla y Objetivo:
Pantalla: 27. Pantalla de Lista de Contactos Externos.
Objetivo: Ofrecer al administrador un directorio centralizado de todos los contactos externos registrados, permitiéndole buscar, ver su información principal (como su institución) y acceder al flujo para añadir nuevos contactos.
Estilo y Composición:
Estilo: El diseño es una lista de datos limpia y funcional, visualmente hermana de la "Lista de Usuarios" para crear una experiencia coherente y predecible dentro de la sección de Administración.
Composición: Una cabecera de navegación, una barra de búsqueda para filtrado, el cuerpo principal con la lista de contactos, y un Botón de Acción Flotante (FAB) para la creación de nuevos registros.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un icono de flecha (<) para regresar al menú de Administración.
En el centro: El título de la pantalla, "Contactos Externos", en Roboto Bold.
[Elemento 2] Barra de Búsqueda: Debajo de la cabecera, una barra de búsqueda para que el administrador pueda encontrar rápidamente a un contacto por su nombre o institución.
[Elemento 3] Lista de Contactos: El área principal de la pantalla, que muestra una lista vertical y desplazable de todos los contactos externos.
[Elemento 4] Tarjeta de Contacto (Componente): Cada contacto en la lista es una tarjeta interactiva.
A la izquierda: Un avatar circular con las iniciales del contacto.
En el centro: El nombre completo del contacto en Roboto Medium. Debajo, el nombre de su institución (ej. "Colegio San Carlos") en Roboto Regular y color gris.
[Elemento 5] Botón de Acción Flotante (FAB): Anclado en la esquina inferior derecha. Es un botón circular de color azul corporativo con un ícono de "+" en blanco para iniciar el flujo de creación de un nuevo contacto externo.
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, lista de contactos, directorio, UI de administración, tarjeta de perfil, aplicación móvil, Botón de Acción Flotante (FAB), funcional, tipografía Roboto, iPhone 13 Pro frame.

Pantalla y Objetivo:
Pantalla: 28. Formulario de Creación/Edición de Contacto Externo.
Objetivo: Permitir al administrador registrar de forma rápida y sencilla los datos de una nueva persona externa para que esté disponible en la base de datos de préstamos.
Estilo y Composición:
Estilo: Un diseño de formulario limpio y funcional, consistente con los otros formularios de la aplicación para una experiencia predecible. La claridad de las etiquetas es la máxima prioridad.
Composición: Una cabecera fija con acciones de cancelar y guardar, seguida de una lista vertical de campos de texto para la entrada de datos.
Componentes Detallados:
[Elemento 1] Cabecera de la Pantalla:
A la izquierda: Un botón de texto "Cancelar".
En el centro: El título de la pantalla, "Crear Contacto Externo", en Roboto Bold.
A la derecha: Un botón de texto "Guardar", que permanece desactivado hasta que se completen los campos obligatorios.
[Elemento 2] Campo de Texto - Nombre Completo: Un campo de entrada de texto estándar con la etiqueta "Nombre Completo*".
[Elemento 3] Campo de Texto - Institución: Un campo de texto con la etiqueta "Institución / Colegio*".
[Elemento 4] Campo de Texto - Cédula o ID: Un campo de texto con la etiqueta "Cédula o ID de Identificación".
[Elemento 5] Campo de Texto - Teléfono: Un campo de entrada de texto optimizado para números de teléfono, con la etiqueta "Teléfono de Contacto".
[Elemento 6] Campo de Texto - Correo Electrónico: Un campo de entrada de texto con la etiqueta "Correo Electrónico".
Marco de Presentación:
Dispositivo: El diseño de la interfaz de usuario se presentará renderizado dentro de un marco de iPhone 13 Pro, visto desde una perspectiva frontal, para proporcionar un contexto realista del producto final.
Toque Final:
Palabras clave: Alta fidelidad, formulario de contacto, UI de administración, campos de texto, directorio, aplicación móvil, diseño funcional, tipografía Roboto, iPhone 13 Pro frame.

