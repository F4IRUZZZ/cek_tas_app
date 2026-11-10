import 'database_helper.dart';
import '../models/visit.dart';
import '../models/visit_item.dart';

class VisitDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Visit>> getAllVisits() async {
    final db = await _dbHelper.db;
    final maps = await db.query('visits', orderBy: 'waktu_masuk DESC');
    return maps.map((m) => Visit.fromMap(m)).toList();
  }

  Future<List<Visit>> getVisitsByPlace(String placeId) async {
    final db = await _dbHelper.db;
    final maps = await db.query(
      'visits',
      where: 'place_id = ?',
      whereArgs: [placeId],
      orderBy: 'waktu_masuk DESC',
    );
    return maps.map((m) => Visit.fromMap(m)).toList();
  }

  Future<Visit?> getVisitById(String id) async {
    final db = await _dbHelper.db;
    final maps = await db.query('visits', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Visit.fromMap(maps.first);
  }

  Future<Visit?> getActiveVisit() async {
    final db = await _dbHelper.db;
    final maps = await db.query(
      'visits',
      where: 'status_selesai = 0',
      orderBy: 'waktu_masuk DESC',
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return Visit.fromMap(maps.first);
  }

  Future<List<VisitItem>> getVisitItems(String visitId) async {
    final db = await _dbHelper.db;
    final maps = await db.query(
      'visit_items',
      where: 'visit_id = ?',
      whereArgs: [visitId],
    );
    return maps.map((m) => VisitItem.fromMap(m)).toList();
  }

  Future<int> insertVisit(Visit visit, List<VisitItem> items) async {
    final db = await _dbHelper.db;
    final batch = db.batch();

    batch.insert('visits', visit.toMap());

    for (final item in items) {
      batch.insert('visit_items', {
        ...item.toMap(),
        'visit_id': visit.id,
      });
    }

    final results = await batch.commit(noResult: true);
    return results.length;
  }

  Future<int> updateVisitItemStatus(String visitId, String itemId, String status) async {
    final db = await _dbHelper.db;
    return await db.update(
      'visit_items',
      {'status': status},
      where: 'visit_id = ? AND item_id = ?',
      whereArgs: [visitId, itemId],
    );
  }

  Future<int> markVisitCompleted(String visitId) async {
    final db = await _dbHelper.db;
    return await db.update(
      'visits',
      {'status_selesai': 1},
      where: 'id = ?',
      whereArgs: [visitId],
    );
  }

  Future<int> deleteVisit(String id) async {
    final db = await _dbHelper.db;
    return await db.delete('visits', where: 'id = ?', whereArgs: [id]);
  }
}
