import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../shared/constants/app_constants.dart';

/// Helper para la gestión de la base de datos local SQLite
class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  
  DatabaseHelper._internal();
  
  /// Singleton instance
  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }
  
  /// Obtiene la instancia de la base de datos
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
  
  /// Inicializa la base de datos
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, AppConstants.localDatabaseName);
    
    return await openDatabase(
      path,
      version: AppConstants.localDatabaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }
  
  /// Crea las tablas iniciales
  Future<void> _onCreate(Database db, int version) async {
    await _createUsersTable(db);
    await _createBranchesTable(db);
    await _createAssetsTable(db);
    await _createLoansTable(db);
    await _createSyncTable(db);
  }
  
  /// Maneja las actualizaciones de esquema
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implementar migraciones futuras aquí
  }
  
  /// Crea la tabla de usuarios
  Future<void> _createUsersTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.usersTable} (
        id TEXT PRIMARY KEY,
        email TEXT NOT NULL UNIQUE,
        full_name TEXT NOT NULL,
        role TEXT NOT NULL,
        branch_id TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }
  
  /// Crea la tabla de sucursales
  Future<void> _createBranchesTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.branchesTable} (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        code TEXT NOT NULL UNIQUE,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }
  
  /// Crea la tabla de activos
  Future<void> _createAssetsTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.assetsTable} (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        value REAL NOT NULL,
        status TEXT NOT NULL DEFAULT 'available',
        branch_id TEXT NOT NULL,
        qr_code TEXT NOT NULL UNIQUE,
        image_url TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (branch_id) REFERENCES ${AppConstants.branchesTable} (id)
      )
    ''');
  }
  
  /// Crea la tabla de préstamos
  Future<void> _createLoansTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.loansTable} (
        id TEXT PRIMARY KEY,
        asset_id TEXT NOT NULL,
        borrower_id TEXT NOT NULL,
        lender_id TEXT NOT NULL,
        start_date TEXT NOT NULL,
        expected_return_date TEXT NOT NULL,
        actual_return_date TEXT,
        status TEXT NOT NULL DEFAULT 'active',
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (asset_id) REFERENCES ${AppConstants.assetsTable} (id),
        FOREIGN KEY (borrower_id) REFERENCES ${AppConstants.usersTable} (id),
        FOREIGN KEY (lender_id) REFERENCES ${AppConstants.usersTable} (id)
      )
    ''');
  }
  
  /// Crea la tabla de sincronización
  Future<void> _createSyncTable(Database db) async {
    await db.execute('''
      CREATE TABLE sync_queue (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        table_name TEXT NOT NULL,
        record_id TEXT NOT NULL,
        operation TEXT NOT NULL,
        data TEXT,
        created_at TEXT NOT NULL,
        attempts INTEGER NOT NULL DEFAULT 0,
        last_attempt TEXT,
        error_message TEXT
      )
    ''');
  }
  
  /// Cierra la base de datos
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
  
  /// Elimina la base de datos (solo para testing)
  Future<void> deleteDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, AppConstants.localDatabaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}