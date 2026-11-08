import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';
import '../widgets/place_card.dart';

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
      context.read<PlaceProvider>().loadPlaces();
    });
  }

  String get _hariIni {
    const hari = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu',
    ];
    final now = DateTime.now();
    return 'Hari ini · ${hari[now.weekday - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlaceProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cek Tas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/places'),
            icon: const Icon(Icons.settings),
            tooltip: 'Kelola Tempat',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: provider.loadPlaces,
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
            _buildKunjunganAktif(context),
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

  Widget _buildKunjunganAktif(BuildContext context) {
    // Fase 3 akan menghubungkan kunjungan aktif ke database
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
              onTap: () => _mulaiKunjungan(context),
            ),
          ),
      ],
    );
  }

  void _mulaiKunjungan(BuildContext context) {
    // Fase 3: navigasi ke pilih tempat + template
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mulai Kunjungan akan tersedia di Fase 3.'),
      ),
    );
  }
}
