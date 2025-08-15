class SupabaseConfig {
  // TODO: Reemplaza estos valores con tus credenciales reales de Supabase
  // Sigue las instrucciones en SUPABASE_SETUP.md para obtener estos valores

  static const String supabaseUrl = 'https://dhkkawbxmexfsaiuzddz.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRoa2thd2J4bWV4ZnNhaXV6ZGR6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyODQ1MjAsImV4cCI6MjA3MDg2MDUyMH0.i2rnzZ6KEgRQvNzJLQH_v5puGkoUOxRoLZxKlnAy_ME';

  // Configuración adicional
  static const bool enableDebugMode = true;
  static const Duration authTimeout = Duration(seconds: 30);

  // Validación de configuración
  static bool get isConfigured {
    return supabaseUrl != 'https://tu-proyecto-id.supabase.co' &&
        supabaseAnonKey != 'tu-clave-publica-aqui' &&
        supabaseUrl.isNotEmpty &&
        supabaseAnonKey.isNotEmpty;
  }

  static void validateConfig() {
    if (!isConfigured) {
      throw Exception('Supabase no está configurado correctamente. '
          'Por favor, actualiza las credenciales en supabase_config.dart '
          'siguiendo las instrucciones en SUPABASE_SETUP.md');
    }
  }
}
