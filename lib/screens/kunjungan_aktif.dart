import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_router.dart';
import '../models/place.dart';
import '../providers/item_provider.dart';
import '../providers/place_provider.dart';
import '../providers/visit_provider.dart';
import '../widgets/place_icon.dart';
import '../widgets/visit_item_tile.dart';

class KunjunganAktifScreen extends StatefulWidget {
  const KunjunganAktifScreen({super.key});

  @override
  State<KunjunganAktifScreen> createState() => _KunjunganAktifScreenState();
}

class _KunjunganAktifScreenState extends State<KunjunganAktifScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitProvider>().loadActiveVisit();
      context.read<PlaceProvider>().loadPlaces();
      context.read<ItemProvider>().loadItems();
    });
  }

  Place? _cariPlace(List<Place> places, String placeId) {
    for (final place in places) {
      if (place.id == placeId) return place;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final visitProvider = context.watch<VisitProvider>();
    final placeProvider = context.watch<PlaceProvider>();
    final itemProvider = context.watch<ItemProvider>();

    final visit = visitProvider.activeVisit;

    if (visit == null) {
      return Scaffold(
        appBar: _appBar(context),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Tidak ada kunjungan aktif.\nMulai kunjungan dari halaman utama.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF888888), height: 1.5),
            ),
          ),
        ),
      );
    }

    final place = _cariPlace(placeProvider.places, visit.placeId);
    final warna = place == null
        ? const Color(0xFF2b2b2b)
        : Color(int.parse(place.warna.replaceFirst('#', '0xFF')));
    final items = visitProvider.activeItems;
    final total = items.length;
    final checked = visitProvider.checkedCount;

    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              PlaceIcon(
                iconType: place?.ikon ?? 'lainnya',
                color: warna,
                size: 44,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place?.nama ?? 'Tempat',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2b2b2b),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Kunjungan Aktif',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$checked/$total',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: warna,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : checked / total,
              minHeight: 8,
              backgroundColor: const Color(0xFFe0e0e0),
              valueColor: AlwaysStoppedAnimation<Color>(warna),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$checked dari $total barang sudah di tas',
            style: const TextStyle(fontSize: 12, color: Color(0xFF555555)),
          ),
          const SizedBox(height: 16),
          ...items.map((visitItem) {
            final item = itemProvider.byId(visitItem.itemId);
            return VisitItemTile(
              nama: item?.nama ?? 'Barang',
              kategori: item?.kategori ?? 'tambahan',
              ikon: item?.ikon ?? 'buku',
              checked: visitItem.status == 'di_tas',
              onChanged: (_) => visitProvider.toggleItem(visitItem.itemId),
            );
          }),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRouter.check),
            style: FilledButton.styleFrom(
              backgroundColor: warna,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Saya Mau Pergi'),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Kunjungan',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close),
      ),
    );
  }
}
