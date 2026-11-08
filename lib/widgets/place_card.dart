import 'package:flutter/material.dart';
import '../models/place.dart';
import 'place_icon.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback? onTap;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PlaceCard({
    super.key,
    required this.place,
    this.onTap,
    this.onToggleFavorite,
    this.onEdit,
    this.onDelete,
  });

  Color get _color => Color(int.parse(place.warna.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              PlaceIcon(
                iconType: place.ikon,
                color: _color,
                size: 44,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.nama,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2b2b2b),
                      ),
                    ),
                    if (place.favorit) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Favorit',
                          style: TextStyle(
                            fontSize: 11,
                            color: _color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onToggleFavorite != null)
                IconButton(
                  onPressed: onToggleFavorite,
                  icon: Icon(
                    place.favorit ? Icons.star : Icons.star_border,
                    color: place.favorit ? Colors.amber : Colors.grey,
                  ),
                ),
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                ),
              if (onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Color(0xFFc0392b),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
