class Item {
  final String? id;
  final String nama;
  final String kategori;
  final String ikon;

  Item({
    this.id,
    required this.nama,
    required this.kategori,
    required this.ikon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'ikon': ikon,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String?,
      nama: map['nama'] as String,
      kategori: map['kategori'] as String,
      ikon: map['ikon'] as String,
    );
  }

  Item copyWith({
    String? id,
    String? nama,
    String? kategori,
    String? ikon,
  }) {
    return Item(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      kategori: kategori ?? this.kategori,
      ikon: ikon ?? this.ikon,
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, nama: $nama, kategori: $kategori, ikon: $ikon)';
  }
}
