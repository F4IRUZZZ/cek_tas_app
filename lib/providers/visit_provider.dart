import 'package:flutter/foundation.dart';

import '../data/visit_dao.dart';
import '../models/item.dart';
import '../models/place.dart';
import '../models/visit.dart';
import '../models/visit_item.dart';

class VisitProvider extends ChangeNotifier {
  final VisitDao _dao = VisitDao();

  Visit? _activeVisit;
  List<VisitItem> _activeItems = [];
  List<Visit> _history = [];
  final Map<String, List<VisitItem>> _historyItems = {};
  bool _isLoading = false;

  Visit? get activeVisit => _activeVisit;
  List<VisitItem> get activeItems => List.unmodifiable(_activeItems);
  List<Visit> get history => List.unmodifiable(_history);
  bool get isLoading => _isLoading;
  bool get hasActiveVisit => _activeVisit != null;

  int get totalCount => _activeItems.length;
  int get checkedCount =>
      _activeItems.where((item) => item.status == 'di_tas').length;

  List<VisitItem> historyItems(String visitId) =>
      List.unmodifiable(_historyItems[visitId] ?? const []);

  Future<void> loadActiveVisit() async {
    _isLoading = true;
    notifyListeners();
    try {
      _activeVisit = await _dao.getActiveVisit();
      _activeItems = _activeVisit == null
          ? []
          : await _dao.getVisitItems(_activeVisit!.id!);
    } catch (_) {
      _activeVisit = null;
      _activeItems = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> startVisit(Place place, List<Item> templateItems) async {
    final sekarang = DateTime.now();
    final visit = Visit(
      id: sekarang.millisecondsSinceEpoch.toString(),
      placeId: place.id!,
      tanggal: sekarang.toIso8601String(),
      waktuMasuk: sekarang.toIso8601String(),
      statusSelesai: false,
    );
    final visitItems = templateItems
        .map((item) => VisitItem(itemId: item.id!, status: 'belum'))
        .toList();

    await _dao.insertVisit(visit, visitItems);
    await loadActiveVisit();
  }

  Future<void> toggleItem(String itemId) async {
    final visit = _activeVisit;
    if (visit == null) return;

    VisitItem? target;
    for (final item in _activeItems) {
      if (item.itemId == itemId) {
        target = item;
        break;
      }
    }
    if (target == null) return;

    final statusBaru = target.status == 'di_tas' ? 'belum' : 'di_tas';
    await _dao.updateVisitItemStatus(visit.id!, itemId, statusBaru);
    await loadActiveVisit();
  }

  Future<void> completeVisit() async {
    final visit = _activeVisit;
    if (visit == null) return;

    await _dao.markVisitCompleted(visit.id!);
    await loadActiveVisit();
    await loadHistory();
  }

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      _history = await _dao.getAllVisits();
      _historyItems.clear();
      for (final visit in _history) {
        _historyItems[visit.id!] = await _dao.getVisitItems(visit.id!);
      }
    } catch (_) {
      _history = [];
      _historyItems.clear();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
