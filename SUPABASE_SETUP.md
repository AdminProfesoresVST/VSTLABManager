# Configuración de Supabase para VSTLABManager

Esta guía te ayudará a configurar la base de datos Supabase para el proyecto VSTLABManager.

## 1. Crear Cuenta y Proyecto en Supabase

1. Ve a [https://supabase.com](https://supabase.com)
2. Crea una cuenta gratuita o inicia sesión
3. Haz clic en "New Project"
4. Completa los datos:
   - **Name**: VSTLABManager
   - **Database Password**: Crea una contraseña segura (guárdala)
   - **Region**: Selecciona la más cercana a tu ubicación
5. Haz clic en "Create new project"
6. Espera a que el proyecto se inicialice (puede tomar unos minutos)

## 2. Obtener las Credenciales del Proyecto

1. En el dashboard de tu proyecto, ve a **Settings** > **API**
2. Copia los siguientes valores:
   - **Project URL** (algo como: `https://tu-proyecto-id.supabase.co`)
   - **anon public** key (la clave pública)

## 3. Configurar las Variables de Entorno

1. En la raíz del proyecto Flutter, crea un archivo `.env`:
```bash
SUPABASE_URL=https://tu-proyecto-id.supabase.co
SUPABASE_ANON_KEY=tu-clave-publica-aqui
```

2. Asegúrate de que `.env` esté en tu `.gitignore` para no subir las credenciales al repositorio.

## 4. Crear las Tablas de la Base de Datos

1. En el dashboard de Supabase, ve a **SQL Editor**
2. Ejecuta el siguiente script SQL para crear todas las tablas necesarias:

```sql
-- Crear tabla de usuarios (profiles)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  role TEXT DEFAULT 'user' CHECK (role IN ('admin', 'user')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de sucursales
CREATE TABLE branches (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT,
  phone TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de activos
CREATE TABLE assets (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  serial_number TEXT UNIQUE,
  qr_code TEXT UNIQUE NOT NULL,
  category TEXT NOT NULL,
  status TEXT DEFAULT 'available' CHECK (status IN ('available', 'loaned', 'maintenance', 'retired')),
  branch_id UUID REFERENCES branches(id),
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear tabla de préstamos
CREATE TABLE loans (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  asset_id UUID REFERENCES assets(id) NOT NULL,
  borrower_name TEXT NOT NULL,
  borrower_email TEXT,
  borrower_phone TEXT,
  loan_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  expected_return_date TIMESTAMP WITH TIME ZONE,
  actual_return_date TIMESTAMP WITH TIME ZONE,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'returned', 'overdue')),
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_assets_qr_code ON assets(qr_code);
CREATE INDEX idx_assets_status ON assets(status);
CREATE INDEX idx_loans_status ON loans(status);
CREATE INDEX idx_loans_asset_id ON loans(asset_id);

-- Crear función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Crear triggers para actualizar updated_at
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_branches_updated_at BEFORE UPDATE ON branches
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_assets_updated_at BEFORE UPDATE ON assets
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_loans_updated_at BEFORE UPDATE ON loans
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

## 5. Configurar Row Level Security (RLS)

1. En el **SQL Editor**, ejecuta el siguiente script para habilitar la seguridad:

```sql
-- Habilitar RLS en todas las tablas
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE branches ENABLE ROW LEVEL SECURITY;
ALTER TABLE assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE loans ENABLE ROW LEVEL SECURITY;

-- Políticas para profiles
CREATE POLICY "Users can view own profile" ON profiles
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON profiles
    FOR UPDATE USING (auth.uid() = id);

-- Políticas para branches (solo lectura para usuarios normales)
CREATE POLICY "Anyone can view branches" ON branches
    FOR SELECT USING (true);

-- Políticas para assets
CREATE POLICY "Anyone can view assets" ON assets
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can create assets" ON assets
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Users can update assets they created" ON assets
    FOR UPDATE USING (auth.uid() = created_by);

-- Políticas para loans
CREATE POLICY "Anyone can view loans" ON loans
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can create loans" ON loans
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Users can update loans they created" ON loans
    FOR UPDATE USING (auth.uid() = created_by);
```

## 6. Crear Función para Auto-crear Profile

1. Ejecuta este script para crear automáticamente un perfil cuando un usuario se registra:

```sql
-- Función para crear perfil automáticamente
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'full_name');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger para ejecutar la función
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

## 7. Insertar Datos de Prueba (Opcional)

1. Ejecuta este script para insertar algunos datos de prueba:

```sql
-- Insertar sucursal de prueba
INSERT INTO branches (name, address, phone) VALUES
('Laboratorio Principal', 'Av. Universidad 123, Ciudad', '+1234567890');

-- Insertar algunos activos de prueba
INSERT INTO assets (name, description, serial_number, qr_code, category, branch_id) VALUES
('Laptop Dell Inspiron', 'Laptop para desarrollo', 'DL001', 'QR_LAPTOP_001', 'Computadoras', (SELECT id FROM branches LIMIT 1)),
('Proyector Epson', 'Proyector para presentaciones', 'EP001', 'QR_PROJECTOR_001', 'Audio/Video', (SELECT id FROM branches LIMIT 1)),
('Microscopio Olympus', 'Microscopio óptico', 'OL001', 'QR_MICROSCOPE_001', 'Laboratorio', (SELECT id FROM branches LIMIT 1));
```

## 8. Configurar Autenticación

1. Ve a **Authentication** > **Settings**
2. En **Site URL**, agrega: `http://localhost:3000` (para desarrollo)
3. En **Redirect URLs**, agrega: `http://localhost:3000/**`
4. Habilita los proveedores de autenticación que desees usar (Email/Password está habilitado por defecto)

## 9. Actualizar el Archivo de Configuración de Flutter

1. Actualiza el archivo `lib/src/core/config/supabase_config.dart` con tus credenciales:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'TU_SUPABASE_URL_AQUI';
  static const String supabaseAnonKey = 'TU_SUPABASE_ANON_KEY_AQUI';
}
```

## 10. Verificar la Conexión

1. Ejecuta la aplicación Flutter
2. Intenta registrar un nuevo usuario
3. Verifica en el dashboard de Supabase que:
   - El usuario aparece en **Authentication** > **Users**
   - Se creó automáticamente un perfil en la tabla `profiles`

## Solución de Problemas Comunes

### Error de Conexión
- Verifica que las URLs y claves sean correctas
- Asegúrate de que el proyecto esté activo en Supabase

### Error de Autenticación
- Verifica que RLS esté configurado correctamente
- Revisa las políticas de seguridad

### Error de Inserción
- Verifica que las tablas existan
- Revisa que los tipos de datos coincidan

## Recursos Adicionales

- [Documentación oficial de Supabase](https://supabase.com/docs)
- [Guía de Flutter con Supabase](https://supabase.com/docs/guides/getting-started/tutorials/with-flutter)
- [Row Level Security en Supabase](https://supabase.com/docs/guides/auth/row-level-security)

---

**¡Importante!** Guarda tus credenciales de Supabase en un lugar seguro y nunca las subas al repositorio público.