import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final sqlDb = await _getDb();
    sqlDb.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> select(String table) async {
    final sqlDb = await _getDb();
    return sqlDb.query(table);
  }

  static Future<sql.Database> _getDb() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) async {
      await db.execute(_kSQLCreateTablePlaces);
    }, version: 1);
  }

  static const String kPlacesTable = 'user_places';

  static const String _kSQLCreateTablePlaces =
      'CREATE TABLE $kPlacesTable (id TEXT PRIMARY KEY, title TEXT, image TEXT, address TEXT)';
}
