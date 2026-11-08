import 'visit_item.dart';

class Visit {
  final String? id;
  final String placeId;
  final String tanggal;
  final String waktuMasuk;
  final List<VisitItem> items;
  final bool statusSelesai;

  Visit({
    this.id,
    required this.placeId,
    required this.tanggal,
    required this.waktuMasuk,
    this.items = const [],
    this.statusSelesai = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place_id': placeId,
      'tanggal': tanggal,
      'waktu_masuk': waktuMasuk,
      'status_selesai': statusSelesai ? 1 : 0,
    };
  }

  factory Visit.fromMap(Map<String, dynamic> map) {
    return Visit(
      id: map['id'] as String?,
      placeId: map['place_id'] as String,
      tanggal: map['tanggal'] as String,
      waktuMasuk: map['waktu_masuk'] as String,
      statusSelesai: (map['status_selesai'] as int) == 1,
    );
  }

  Visit copyWith({
    String? id,
    String? placeId,
    String? tanggal,
    String? waktuMasuk,
    List<VisitItem>? items,
    bool? statusSelesai,
  }) {
    return Visit(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      tanggal: tanggal ?? this.tanggal,
      waktuMasuk: waktuMasuk ?? this.waktuMasuk,
      items: items ?? this.items,
      statusSelesai: statusSelesai ?? this.statusSelesai,
    );
  }

  @override
  String toString() {
    return 'Visit(id: $id, placeId: $placeId, tanggal: $tanggal, waktuMasuk: $waktuMasuk, statusSelesai: $statusSelesai)';
  }
}
