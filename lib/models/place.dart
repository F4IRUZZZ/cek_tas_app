class Place {
  final String? id;
  final String nama;
  final String ikon;
  final String warna;
  final bool favorit;
  final List<String> templateItemIds;

  Place({
    this.id,
    required this.nama,
    required this.ikon,
    required this.warna,
    this.favorit = false,
    this.templateItemIds = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'ikon': ikon,
      'warna': warna,
      'favorit': favorit ? 1 : 0,
      'template_item_ids': templateItemIds.join(','),
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] as String?,
      nama: map['nama'] as String,
      ikon: map['ikon'] as String,
      warna: map['warna'] as String,
      favorit: (map['favorit'] as int) == 1,
      templateItemIds: (map['template_item_ids'] as String?)
          ?.split(',')
          .where((e) => e.isNotEmpty)
          .toList() ?? [],
    );
  }

  Place copyWith({
    String? id,
    String? nama,
    String? ikon,
    String? warna,
    bool? favorit,
    List<String>? templateItemIds,
  }) {
    return Place(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      ikon: ikon ?? this.ikon,
      warna: warna ?? this.warna,
      favorit: favorit ?? this.favorit,
      templateItemIds: templateItemIds ?? this.templateItemIds,
    );
  }

  @override
  String toString() {
    return 'Place(id: $id, nama: $nama, ikon: $ikon, warna: $warna, favorit: $favorit)';
  }
}
