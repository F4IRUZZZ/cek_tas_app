import 'database_helper.dart';
import '../models/item.dart';

class ItemDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Item>> getAllItems() async {
    final db = await _dbHelper.db;
    final maps = await db.query('items', orderBy: 'kategori ASC, nama ASC');
    return maps.map((m) => Item.fromMap(m)).toList();
  }

  Future<List<Item>> getItemsByCategory(String kategori) async {
    final db = await _dbHelper.db;
    final maps = await db.query(
      'items',
      where: 'kategori = ?',
      whereArgs: [kategori],
      orderBy: 'nama ASC',
    );
    return maps.map((m) => Item.fromMap(m)).toList();
  }

  Future<Item?> getItemById(String id) async {
    final db = await _dbHelper.db;
    final maps = await db.query('items', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Item.fromMap(maps.first);
  }

  Future<int> insertItem(Item item) async {
    final db = await _dbHelper.db;
    return await db.insert('items', item.toMap());
  }

  Future<int> updateItem(Item item) async {
    final db = await _dbHelper.db;
    return await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(String id) async {
    final db = await _dbHelper.db;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
