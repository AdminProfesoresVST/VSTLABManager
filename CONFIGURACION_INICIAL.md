# 🚀 Configuración Inicial de VSTLABManager

¡Bienvenido a VSTLABManager! Sigue estos pasos para configurar la aplicación correctamente.

## ⚠️ Error Actual

Actualmente ves un error de conexión porque **Supabase no está configurado**. Esto es normal en la primera ejecución.

## 📋 Pasos para Resolver el Error

### 1. Configurar Supabase (OBLIGATORIO)

1. **Lee la guía completa**: Abre el archivo `SUPABASE_SETUP.md` que contiene instrucciones detalladas
2. **Crea tu proyecto en Supabase**: Ve a [supabase.com](https://supabase.com) y crea una cuenta gratuita
3. **Obtén tus credenciales**: Copia la URL del proyecto y la clave pública (anon key)
4. **Actualiza la configuración**: Edita el archivo `lib/src/core/config/supabase_config.dart` con tus credenciales reales

### 2. Reemplazar Credenciales

En el archivo `lib/src/core/config/supabase_config.dart`, cambia:

```dart
// ❌ CAMBIAR ESTO:
static const String supabaseUrl = 'https://tu-proyecto-id.supabase.co';
static const String supabaseAnonKey = 'tu-clave-publica-aqui';

// ✅ POR TUS CREDENCIALES REALES:
static const String supabaseUrl = 'https://abcdefgh.supabase.co';
static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

### 3. Crear las Tablas de la Base de Datos

En el dashboard de Supabase:
1. Ve a **SQL Editor**
2. Ejecuta los scripts SQL que están en `SUPABASE_SETUP.md`
3. Esto creará todas las tablas necesarias (usuarios, activos, préstamos, etc.)

### 4. Reiniciar la Aplicación

Después de configurar Supabase:
1. Detén la aplicación (presiona `q` en la terminal)
2. Ejecuta `flutter run` nuevamente
3. ¡La aplicación debería funcionar correctamente!

## 🎯 ¿Qué Verás Después de la Configuración?

- **Pantalla de Login/Registro**: Podrás crear una cuenta o iniciar sesión
- **Dashboard Principal**: Con estadísticas y acciones rápidas
- **Gestión de Activos**: Crear, editar y ver activos del laboratorio
- **Sistema de Préstamos**: Prestar y devolver activos
- **Scanner QR**: Escanear códigos QR de los activos

## 🆘 ¿Necesitas Ayuda?

### Problemas Comunes:

1. **"Error de conexión a Supabase"**
   - ✅ Verifica que las credenciales sean correctas
   - ✅ Asegúrate de que el proyecto esté activo en Supabase

2. **"No se pueden crear usuarios"**
   - ✅ Verifica que las tablas estén creadas
   - ✅ Revisa que RLS (Row Level Security) esté configurado

3. **"La aplicación se cierra"**
   - ✅ Revisa la consola de Flutter para errores específicos
   - ✅ Asegúrate de que todas las dependencias estén instaladas

### Archivos Importantes:

- `SUPABASE_SETUP.md` - Guía completa de configuración de Supabase
- `lib/src/core/config/supabase_config.dart` - Archivo de configuración
- `.env.example` - Ejemplo de variables de entorno

## 🎉 ¡Listo para Empezar!

Una vez completada la configuración, tendrás un sistema completo de gestión de activos de laboratorio con:

- ✅ Autenticación segura
- ✅ Base de datos en la nube
- ✅ Sincronización offline-first
- ✅ Generación y escaneo de códigos QR
- ✅ Sistema completo de préstamos

---

**💡 Tip**: Si tienes dudas, revisa primero `SUPABASE_SETUP.md` que tiene instrucciones paso a paso con capturas de pantalla.