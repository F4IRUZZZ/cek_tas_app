import 'package:flutter/foundation.dart';
import '../data/place_dao.dart';
import '../models/place.dart';

class PlaceProvider extends ChangeNotifier {
  final PlaceDao _dao = PlaceDao();

  List<Place> _places = [];
  List<Place> get places => _places;

  List<Place> get favorites => _places.where((p) => p.favorit).toList();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadPlaces() async {
    _isLoading = true;
    notifyListeners();

    try {
      _places = await _dao.getAllPlaces();
    } catch (_) {
      _places = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addPlace(Place place) async {
    try {
      await _dao.insertPlace(place);
      await loadPlaces();
      return true;
    } catch (_) {
      await loadPlaces();
      return false;
    }
  }

  Future<bool> updatePlace(Place place) async {
    try {
      await _dao.updatePlace(place);
      await loadPlaces();
      return true;
    } catch (_) {
      await loadPlaces();
      return false;
    }
  }

  Future<void> deletePlace(String id) async {
    await _dao.deletePlace(id);
    await loadPlaces();
  }

  Future<void> toggleFavorite(String id) async {
    final place = _places.firstWhere((p) => p.id == id);
    await _dao.toggleFavorite(id, !place.favorit);
    await loadPlaces();
  }
}
