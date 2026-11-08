import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'cek_tas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE places(
        id TEXT PRIMARY KEY,
        nama TEXT NOT NULL,
        ikon TEXT NOT NULL,
        warna TEXT NOT NULL,
        favorit INTEGER NOT NULL DEFAULT 0,
        template_item_ids TEXT NOT NULL DEFAULT ''
      )
    ''');

    await db.execute('''
      CREATE TABLE items(
        id TEXT PRIMARY KEY,
        nama TEXT NOT NULL,
        kategori TEXT NOT NULL,
        ikon TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE visits(
        id TEXT PRIMARY KEY,
        place_id TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        waktu_masuk TEXT NOT NULL,
        status_selesai INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(place_id) REFERENCES places(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE visit_items(
        item_id TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'belum',
        visit_id TEXT NOT NULL,
        PRIMARY KEY(item_id, visit_id),
        FOREIGN KEY(visit_id) REFERENCES visits(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> close() async {
    final d = _db;
    if (d != null && d.isOpen) {
      await d.close();
      _db = null;
    }
  }
}
