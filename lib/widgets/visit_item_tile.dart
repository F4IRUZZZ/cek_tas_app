import 'package:flutter/material.dart';

import 'category_chip.dart';
import 'place_icon.dart';

class VisitItemTile extends StatelessWidget {
  final String nama;
  final String kategori;
  final String ikon;
  final bool checked;
  final ValueChanged<bool>? onChanged;

  const VisitItemTile({
    super.key,
    required this.nama,
    required this.kategori,
    required this.ikon,
    required this.checked,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = checked ? const Color(0xFF2e7d32) : const Color(0xFF2b2b2b);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: checked
              ? const Color(0xFF2e7d32).withValues(alpha: 0.45)
              : const Color(0xFFe0e0e0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onChanged == null ? null : () => onChanged!(!checked),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              PlaceIcon(iconType: ikon, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2b2b2b),
                        decoration:
                            checked ? TextDecoration.lineThrough : null,
                        decorationColor: const Color(0xFF888888),
                      ),
                    ),
                    const SizedBox(height: 4),
                    CategoryChip(kategori: kategori, small: true),
                  ],
                ),
              ),
              Checkbox(
                value: checked,
                activeColor: const Color(0xFF2e7d32),
                onChanged: onChanged == null
                    ? null
                    : (value) => onChanged!(value ?? false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
