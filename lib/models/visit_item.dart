class VisitItem {
  final String itemId;
  final String status;

  VisitItem({
    required this.itemId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'status': status,
    };
  }

  factory VisitItem.fromMap(Map<String, dynamic> map) {
    return VisitItem(
      itemId: map['item_id'] as String,
      status: map['status'] as String,
    );
  }

  VisitItem copyWith({
    String? itemId,
    String? status,
  }) {
    return VisitItem(
      itemId: itemId ?? this.itemId,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'VisitItem(itemId: $itemId, status: $status)';
  }
}
