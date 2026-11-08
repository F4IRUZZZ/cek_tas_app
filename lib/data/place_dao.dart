import 'database_helper.dart';
import '../models/place.dart';

class PlaceDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Place>> getAllPlaces() async {
    final db = await _dbHelper.db;
    final maps = await db.query('places', orderBy: 'favorit DESC, nama ASC');
    return maps.map((m) => Place.fromMap(m)).toList();
  }

  Future<List<Place>> getFavoritePlaces() async {
    final db = await _dbHelper.db;
    final maps = await db.query(
      'places',
      where: 'favorit = 1',
      orderBy: 'nama ASC',
    );
    return maps.map((m) => Place.fromMap(m)).toList();
  }

  Future<Place?> getPlaceById(String id) async {
    final db = await _dbHelper.db;
    final maps = await db.query('places', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Place.fromMap(maps.first);
  }

  Future<int> insertPlace(Place place) async {
    final db = await _dbHelper.db;
    return await db.insert('places', place.toMap());
  }

  Future<int> updatePlace(Place place) async {
    final db = await _dbHelper.db;
    return await db.update(
      'places',
      place.toMap(),
      where: 'id = ?',
      whereArgs: [place.id],
    );
  }

  Future<int> deletePlace(String id) async {
    final db = await _dbHelper.db;
    return await db.delete('places', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> toggleFavorite(String id, bool favorit) async {
    final db = await _dbHelper.db;
    return await db.update(
      'places',
      {'favorit': favorit ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
