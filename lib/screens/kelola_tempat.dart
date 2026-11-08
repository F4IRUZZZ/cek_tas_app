import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../providers/place_provider.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/place_card.dart';
import '../widgets/place_icon.dart';

const _warnaPilihan = [
  '#c0392b',
  '#2e7d32',
  '#2b2b2b',
  '#f4f4f4',
  '#2962ff',
  '#ff6d00',
  '#6a1b9a',
  '#00838f',
];

const _ikonPilihan = [
  'laptop',
  'charger',
  'buku',
  'tumbler',
  'dompet',
  'hp',
  'earphone',
  'game',
  'kamera',
];

class KelolaTempatScreen extends StatelessWidget {
  const KelolaTempatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlaceProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Tempat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.places.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada tempat.\nTambah tempat pertama.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF888888), height: 1.5),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: provider.places
                      .map(
                        (place) => PlaceCard(
                          place: place,
                          onToggleFavorite: () =>
                              provider.toggleFavorite(place.id!),
                          onEdit: () => _bukaForm(context, place: place),
                          onDelete: () => _hapusTempat(context, place),
                        ),
                      )
                      .toList(),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bukaForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Tempat'),
      ),
    );
  }

  void _bukaForm(BuildContext context, {Place? place}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormTempatScreen(place: place),
      ),
    );
  }

  Future<void> _hapusTempat(BuildContext context, Place place) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'Hapus Tempat?',
      message: 'Tempat "${place.nama}" dan template bawaannya akan dihapus permanen.',
      confirmLabel: 'Hapus',
    );

    if (confirmed && context.mounted) {
      await context.read<PlaceProvider>().deletePlace(place.id!);
    }
  }
}

class FormTempatScreen extends StatefulWidget {
  final Place? place;

  const FormTempatScreen({super.key, this.place});

  @override
  State<FormTempatScreen> createState() => _FormTempatScreenState();
}

class _FormTempatScreenState extends State<FormTempatScreen> {
  late final TextEditingController _namaCtrl;
  late String _ikon;
  late String _warna;
  late bool _favorit;

  bool get _isEdit => widget.place != null;

  @override
  void initState() {
    super.initState();
    _namaCtrl = TextEditingController(text: widget.place?.nama ?? '');
    _ikon = widget.place?.ikon ?? _ikonPilihan.first;
    _warna = widget.place?.warna ?? _warnaPilihan.first;
    _favorit = widget.place?.favorit ?? false;
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(_warna.replaceFirst('#', '0xFF')));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? 'Edit Tempat' : 'Tempat Baru',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: PlaceIcon(iconType: _ikon, color: color, size: 72),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _namaCtrl,
            decoration: InputDecoration(
              labelText: 'Nama Tempat',
              hintText: 'Sekolah, Cafe ABC, Mall...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Ikon',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2b2b2b),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _ikonPilihan.map((t) {
              final selected = t == _ikon;
              return GestureDetector(
                onTap: () => setState(() => _ikon = t),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: selected
                        ? color.withValues(alpha: 0.15)
                        : const Color(0xFFf4f4f4),
                    border: Border.all(
                      color: selected ? color : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: PlaceIcon(
                    iconType: t,
                    color: selected ? color : const Color(0xFF888888),
                    size: 32,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Warna',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2b2b2b),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _warnaPilihan.map((w) {
              final c = Color(int.parse(w.replaceFirst('#', '0xFF')));
              final selected = w == _warna;
              return GestureDetector(
                onTap: () => setState(() => _warna = w),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? const Color(0xFF2b2b2b) : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: selected
                      ? const Icon(Icons.check, color: Colors.white, size: 20)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Jadikan Favorit'),
            subtitle: const Text('Muncul di atas daftar Home'),
            value: _favorit,
            onChanged: (v) => setState(() => _favorit = v),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _simpan,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF2b2b2b),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Simpan Tempat',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _simpan() async {
    final nama = _namaCtrl.text.trim();
    if (nama.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tempat wajib diisi.')),
      );
      return;
    }

    final provider = context.read<PlaceProvider>();

    if (_isEdit) {
      await provider.updatePlace(
        widget.place!.copyWith(
          nama: nama,
          ikon: _ikon,
          warna: _warna,
          favorit: _favorit,
        ),
      );
    } else {
      await provider.addPlace(
        Place(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          nama: nama,
          ikon: _ikon,
          warna: _warna,
          favorit: _favorit,
        ),
      );
    }

    if (mounted) Navigator.pop(context);
  }
}
