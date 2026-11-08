import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String kategori;
  final bool small;

  const CategoryChip({
    super.key,
    required this.kategori,
    this.small = false,
  });

  bool get _isWajib => kategori.toLowerCase() == 'wajib';

  @override
  Widget build(BuildContext context) {
    final color = _isWajib ? const Color(0xFFc0392b) : const Color(0xFF555555);

    return Container(
      padding: small
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 2)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        kategori.toLowerCase(),
        style: TextStyle(
          fontSize: small ? 11 : 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
