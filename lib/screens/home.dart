import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_router.dart';
import '../models/place.dart';
import '../providers/item_provider.dart';
import '../providers/place_provider.dart';
import '../providers/visit_provider.dart';
import '../screens/template_per_tempat.dart';
import '../widgets/place_card.dart';
import '../widgets/place_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _muatUlang();
    });
  }

  Future<void> _muatUlang() async {
    await Future.wait([
      context.read<PlaceProvider>().loadPlaces(),
      context.read<ItemProvider>().loadItems(),
      context.read<VisitProvider>().loadActiveVisit(),
    ]);
  }

  String get _hariIni {
    const hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    final now = DateTime.now();
    return 'Hari ini - ${hari[now.weekday - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlaceProvider>();
    final visitProvider = context.watch<VisitProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cek Tas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, AppRouter.history);
              await _muatUlang();
            },
            icon: const Icon(Icons.history),
            tooltip: 'Riwayat',
          ),
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, AppRouter.places);
              await _muatUlang();
            },
            icon: const Icon(Icons.settings),
            tooltip: 'Kelola Tempat',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _muatUlang,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              _hariIni,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2b2b2b),
              ),
            ),
            const SizedBox(height: 16),
            _buildKunjunganAktif(context, provider, visitProvider),
            const SizedBox(height: 24),
            _buildTempatFavorit(context, provider),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mulaiKunjungan(context),
        icon: const Icon(Icons.play_arrow),
        label: const Text('Mulai Kunjungan'),
      ),
    );
  }

  Widget _buildKunjunganAktif(
    BuildContext context,
    PlaceProvider placeProvider,
    VisitProvider visitProvider,
  ) {
    final visit = visitProvider.activeVisit;

    if (visit == null) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kunjungan Aktif',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2b2b2b),
                ),
              ),
              SizedBox(height: 12),
              Center(
                child: Text(
                  'Belum ada kunjungan aktif.\nMulai kunjungan pertama.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF888888), height: 1.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Place? place;
    for (final p in placeProvider.places) {
      if (p.id == visit.placeId) {
        place = p;
        break;
      }
    }
    final warna = place == null
        ? const Color(0xFF2b2b2b)
        : Color(int.parse(place.warna.replaceFirst('#', '0xFF')));
    final total = visitProvider.totalCount;
    final checked = visitProvider.checkedCount;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          await Navigator.pushNamed(context, AppRouter.visit);
          await _muatUlang();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kunjungan Aktif',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2b2b2b),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  PlaceIcon(
                    iconType: place?.ikon ?? 'lainnya',
                    color: warna,
                    size: 36,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      place?.nama ?? 'Tempat',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2b2b2b),
                      ),
                    ),
                  ),
                  Text(
                    '$checked/$total',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warna,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: total == 0 ? 0 : checked / total,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFe0e0e0),
                  valueColor: AlwaysStoppedAnimation<Color>(warna),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$checked dari $total barang sudah di tas',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTempatFavorit(BuildContext context, PlaceProvider provider) {
    final favorites = provider.favorites;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tempat Favorit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2b2b2b),
          ),
        ),
        const SizedBox(height: 12),
        if (provider.isLoading)
          const Center(child: CircularProgressIndicator())
        else if (favorites.isEmpty)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Belum ada tempat favorit.\nTandai tempat sebagai favorit di Kelola Tempat.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF888888), height: 1.5),
                ),
              ),
            ),
          )
        else
          ...favorites.map(
            (place) => PlaceCard(
              place: place,
              onTap: () => _bukaTemplate(context, place),
            ),
          ),
      ],
    );
  }

  Future<void> _mulaiKunjungan(BuildContext context) async {
    final visitProvider = context.read<VisitProvider>();
    if (visitProvider.hasActiveVisit) {
      await Navigator.pushNamed(context, AppRouter.visit);
      await _muatUlang();
      return;
    }

    final places = context.read<PlaceProvider>().places;
    if (places.isEmpty) {
      _pesan('Tambah tempat dulu di Kelola Tempat.');
      return;
    }

    final place = await showModalBottomSheet<Place>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _PilihTempatSheet(places: places),
    );
    if (place == null || !context.mounted) return;

    await _bukaTemplate(context, place);
  }

  Future<void> _bukaTemplate(BuildContext context, Place place) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TemplateTempatScreen(place: place),
      ),
    );
    await _muatUlang();
  }

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }
}

class _PilihTempatSheet extends StatelessWidget {
  final List<Place> places;

  const _PilihTempatSheet({required this.places});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(
              'Mau ke mana?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2b2b2b),
              ),
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              children: places.map((place) {
                final warna =
                    Color(int.parse(place.warna.replaceFirst('#', '0xFF')));
                return ListTile(
                  leading: PlaceIcon(
                    iconType: place.ikon,
                    color: warna,
                    size: 32,
                  ),
                  title: Text(
                    place.nama,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2b2b2b),
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 20),
                  onTap: () => Navigator.pop(context, place),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
