import 'package:flutter/foundation.dart';

import '../data/item_dao.dart';
import '../models/item.dart';

class ItemProvider extends ChangeNotifier {
  final ItemDao _dao = ItemDao();

  List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;

  Item? byId(String id) {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }

  Future<void> loadItems() async {
    _isLoading = true;
    notifyListeners();
    try {
      _items = await _dao.getAllItems();
    } catch (_) {
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Item> addItem(Item item) async {
    await _dao.insertItem(item);
    await loadItems();
    return item;
  }

  Future<void> updateItem(Item item) async {
    await _dao.updateItem(item);
    await loadItems();
  }

  Future<void> deleteItem(String id) async {
    await _dao.deleteItem(id);
    await loadItems();
  }
}
