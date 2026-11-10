import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/item_provider.dart';
import '../providers/place_provider.dart';
import '../providers/visit_provider.dart';
import '../utils/tanggal.dart';
import '../widgets/place_icon.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitProvider>().loadHistory();
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: visitProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : visitProvider.history.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada riwayat kunjungan.',
                    style: TextStyle(color: Color(0xFF888888)),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: visitProvider.loadHistory,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: visitProvider.history
                        .map(
                          (visit) => _kartuRiwayat(
                            context,
                            visitProvider,
                            placeProvider.places,
                            visit.id!,
                            visit.placeId,
                            visit.tanggal,
                          ),
                        )
                        .toList(),
                  ),
                ),
    );
  }

  Widget _kartuRiwayat(
    BuildContext context,
    VisitProvider provider,
    List<Place> places,
    String visitId,
    String placeId,
    String tanggalIso,
  ) {
    final place = _cariPlace(places, placeId);
    final warna = place == null
        ? const Color(0xFF2b2b2b)
        : Color(int.parse(place.warna.replaceFirst('#', '0xFF')));

    final items = provider.historyItems(visitId);
    final lupa = items.where((i) => i.status != 'di_tas').length;
    final aman = lupa == 0;
    final tanggal = DateTime.tryParse(tanggalIso);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            PlaceIcon(
              iconType: place?.ikon ?? 'lainnya',
              color: warna,
              size: 36,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place?.nama ?? 'Tempat',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2b2b2b),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tanggal == null
                        ? '-'
                        : '${tanggalSingkat(tanggal)} - ${jamMenit(tanggal)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                  if (!aman) ...[
                    const SizedBox(height: 4),
                    Text(
                      '$lupa barang tertinggal',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFc0392b),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            _chipStatus(aman),
          ],
        ),
      ),
    );
  }

  Widget _chipStatus(bool aman) {
    final warna = aman ? const Color(0xFF2e7d32) : const Color(0xFFc0392b);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: warna.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            aman ? Icons.check_circle_outline : Icons.error_outline,
            size: 14,
            color: warna,
          ),
          const SizedBox(width: 4),
          Text(
            aman ? 'Aman' : 'Lupa',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: warna,
            ),
          ),
        ],
      ),
    );
  }
}
