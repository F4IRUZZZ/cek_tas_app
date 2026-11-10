import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_router.dart';
import '../models/place.dart';
import '../providers/item_provider.dart';
import '../providers/place_provider.dart';
import '../providers/visit_provider.dart';
import '../widgets/place_icon.dart';
import '../widgets/visit_item_tile.dart';

class CekSebelumPergiScreen extends StatefulWidget {
  const CekSebelumPergiScreen({super.key});

  @override
  State<CekSebelumPergiScreen> createState() => _CekSebelumPergiScreenState();
}

class _CekSebelumPergiScreenState extends State<CekSebelumPergiScreen> {
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

  Future<void> _selesai() async {
    final visitProvider = context.read<VisitProvider>();
    await visitProvider.completeVisit();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouter.history,
      (route) => route.isFirst,
    );
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
          child: Text(
            'Tidak ada kunjungan aktif.',
            style: TextStyle(color: Color(0xFF888888)),
          ),
        ),
      );
    }

    final place = _cariPlace(placeProvider.places, visit.placeId);
    final warna = place == null
        ? const Color(0xFF2b2b2b)
        : Color(int.parse(place.warna.replaceFirst('#', '0xFF')));
    final items = visitProvider.activeItems;

    var wajibBelum = 0;
    var semuaTercentang = true;
    for (final visitItem in items) {
      if (visitItem.status != 'di_tas') {
        semuaTercentang = false;
        final item = itemProvider.byId(visitItem.itemId);
        if (item == null || item.kategori.toLowerCase() == 'wajib') {
          wajibBelum++;
        }
      }
    }

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
                size: 40,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  place?.nama ?? 'Tempat',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2b2b2b),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (semuaTercentang)
            _kotak(
              warna: const Color(0xFF2e7d32),
              ikon: Icons.check_circle,
              judul: 'Tas Lengkap',
              pesan: 'Semua barang sudah masuk tas. Aman!',
            )
          else
            _kotak(
              warna: const Color(0xFFc0392b),
              ikon: Icons.warning_amber_rounded,
              judul: 'Belum Lengkap',
              pesan: wajibBelum > 0
                  ? 'Masih ada $wajibBelum barang wajib belum dibereskan '
                      'di ${place?.nama ?? 'tempat ini'}!'
                  : 'Masih ada barang yang belum dicentang.',
            ),
          const SizedBox(height: 16),
          const Text(
            'Periksa sekali lagi sebelum pergi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2b2b2b),
            ),
          ),
          const SizedBox(height: 10),
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
          child: FilledButton(
            onPressed: _selesai,
            style: FilledButton.styleFrom(
              backgroundColor: semuaTercentang
                  ? const Color(0xFF2e7d32)
                  : const Color(0xFFc0392b),
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Tandai Selesai'),
          ),
        ),
      ),
    );
  }

  Widget _kotak({
    required Color warna,
    required IconData ikon,
    required String judul,
    required String pesan,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warna.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: warna, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warna,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pesan,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF555555),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Cek Sebelum Pergi',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
