Reglas de Programación y Estándares de Calidad: VSTLABManager
Este documento establece las directrices y estándares obligatorios para todo el código desarrollado en el proyecto VSTLABManager. Su propósito es asegurar la creación de una base de código limpia, consistente, mantenible y de alta calidad.

1. Lenguaje, Nomenclatura y Estilo
1.1. Lenguaje Inclusivo y Profesional: Queda estrictamente prohibido el uso de terminología ofensiva, excluyente o no profesional en cualquier parte del proyecto (código, comentarios, documentación, mensajes de commit). Se deben preferir alternativas modernas y neutrales.

Ejemplos a evitar: blacklist/whitelist, master/slave.

Ejemplos a usar: denylist/allowlist, primary/replica o main/secondary.

1.2. Nomenclatura de Dart/Flutter: Se seguirá estrictamente la guía de estilo oficial de Dart.

PascalCase para clases, enums, extensiones y typedefs. (Ej: AssetRepository, StatusEnum).

camelCase para variables, constantes, parámetros y métodos. (Ej: currentAsset, fetchData()).

snake_case para nombres de archivos y directorios. (Ej: asset_detail_screen.dart).

1.3. Linter: El código debe cumplir con todas las reglas del linter configurado en el archivo analysis_options.yaml del proyecto. No se aceptarán Pull Requests con advertencias o errores del linter.

2. Arquitectura y Estructura del Código
2.1. Adherencia a la Arquitectura Limpia: La separación de capas (Presentación, Dominio, Datos) es mandatoria. La lógica de la UI no debe contener lógica de negocio. Las dependencias deben fluir siempre hacia el centro (hacia el Dominio).

2.2. Principio Offline-First: Toda operación que modifique datos (Crear, Actualizar, Borrar) debe realizarse primero contra la base de datos local (sqflite). Un servicio de sincronización en segundo plano será el único responsable de comunicar estos cambios a Supabase.

2.3. Inyección de Dependencias: Todos los repositorios, servicios y otras dependencias deben ser accedidos a través de Riverpod. Queda prohibida la instanciación manual de dependencias dentro de las clases de la UI o controladores (ej: final repo = AssetRepositoryImpl(); está prohibido).

3. Gestión de Estado
3.1. Uso Exclusivo de Riverpod: Riverpod es la única herramienta autorizada para la gestión de estado de la aplicación. Se debe evitar el uso de StatefulWidget con setState() para manejar estados complejos que afecten a la lógica de negocio o a múltiples widgets.

3.2. Estado Inmutable: Los StateNotifiers o Providers deben exponer siempre un estado inmutable. Para actualizar el estado, se debe crear una nueva instancia del objeto de estado en lugar de mutar la existente.

4. Calidad y Buenas Prácticas de Código
4.1. No Utilizar APIs Obsoletas (Deprecated): El código no debe contener llamadas a métodos, clases o parámetros que estén marcados como @deprecated. Todas las advertencias de este tipo arrojadas por el analizador de Flutter/Dart deben ser resueltas antes de integrar el código.

4.2. Evitar "Valores Mágicos": No se permiten "magic strings" o "magic numbers" directamente en el código. Deben ser definidos como constantes en un archivo centralizado (ej: lib/src/shared/constants.dart).

4.3. Manejo de Errores Explícito: Las funciones que puedan fallar (especialmente las de los repositorios) deben retornar un tipo de dato que maneje explícitamente el éxito o el error (ej: usando el paquete dartz con Either<Failure, Success>), en lugar de lanzar excepciones que deban ser capturadas con try-catch en la capa de presentación.

Esta regla ahora forma parte de los estándares generales del proyecto.

5. Pruebas (Testing)
5.1. Pruebas Unitarias: Toda la lógica de negocio contenida en controladores, notifiers y repositorios debe tener una cobertura de pruebas unitarias de al menos el 80%.

5.2. Pruebas de Widgets: Se requieren pruebas de widgets para componentes de UI complejos o con múltiples estados.

5.3. Pruebas en Dispositivos Físicos: Antes de que una historia de usuario pueda ser considerada "Hecha", su funcionalidad debe ser verificada en un dispositivo físico real (iOS o Android). Las pruebas en emuladores son necesarias pero no suficientes. Esto garantiza la validación del rendimiento, gestos táctiles y comportamiento en el mundo real.
6. Control de Versiones (Git)
6.1. Flujo de Ramas: Todo trabajo nuevo debe realizarse en una rama de feature (feature/HU-XXX-descripcion-corta) creada a partir de develop.

6.2. Mensajes de Commit Semánticos: Todos los mensajes de commit deben seguir la especificación de Conventional Commits.

Ejemplos: feat(auth): add login screen UI, fix(assets): solve qr scanner crash, refactor(loans): improve state management.
