import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_router.dart';
import '../models/item.dart';
import '../models/place.dart';
import '../providers/item_provider.dart';
import '../providers/place_provider.dart';
import '../providers/visit_provider.dart';
import '../widgets/place_icon.dart';

const _ikonBarang = [
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

class TemplateTempatScreen extends StatefulWidget {
  final Place place;

  const TemplateTempatScreen({super.key, required this.place});

  @override
  State<TemplateTempatScreen> createState() => _TemplateTempatScreenState();
}

class _TemplateTempatScreenState extends State<TemplateTempatScreen> {
  late final Set<String> _terpilih;

  Color get _warna =>
      Color(int.parse(widget.place.warna.replaceFirst('#', '0xFF')));

  @override
  void initState() {
    super.initState();
    _terpilih = {...widget.place.templateItemIds};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemProvider>().loadItems();
    });
  }

  Place _placeTerkini() {
    final places = context.read<PlaceProvider>().places;
    for (final place in places) {
      if (place.id == widget.place.id) return place;
    }
    return widget.place;
  }

  Future<void> _simpanTemplate() async {
    final place = _placeTerkini();
    await context.read<PlaceProvider>().updatePlace(
          place.copyWith(templateItemIds: _terpilih.toList()),
        );
  }

  Future<void> _toggle(Item item, bool dipilih) async {
    setState(() {
      if (dipilih) {
        _terpilih.add(item.id!);
      } else {
        _terpilih.remove(item.id);
      }
    });
    await _simpanTemplate();
  }

  Future<void> _tambahBarang() async {
    final item = await showDialog<Item>(
      context: context,
      builder: (_) => _TambahBarangDialog(warna: _warna),
    );
    if (item == null || !mounted) return;

    final itemProvider = context.read<ItemProvider>();
    await itemProvider.addItem(item);
    if (!mounted) return;
    setState(() => _terpilih.add(item.id!));
    await _simpanTemplate();
  }

  Future<void> _pakaiTemplate() async {
    final items = context
        .read<ItemProvider>()
        .items
        .where((item) => _terpilih.contains(item.id))
        .toList();

    if (items.isEmpty) {
      _pesan('Pilih minimal satu barang dulu.');
      return;
    }

    final visitProvider = context.read<VisitProvider>();
    if (visitProvider.hasActiveVisit) {
      _pesan('Masih ada kunjungan aktif. Selesaikan dulu sebelum mulai baru.');
      return;
    }

    await visitProvider.startVisit(_placeTerkini(), items);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRouter.visit);
  }

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = context.watch<ItemProvider>();
    final items = itemProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bawaan Default',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Column(
        children: [
          _header(),
          Expanded(
            child: itemProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : items.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada barang.\nTambah barang bawaan dulu.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF888888),
                            height: 1.5,
                          ),
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        children: [
                          ...items.map(
                            (item) => _barisBarang(item),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: _tambahBarang,
                            icon: const Icon(Icons.add),
                            label: const Text('Tambah Barang'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _warna,
                              side: BorderSide(color: _warna),
                              minimumSize: const Size.fromHeight(44),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: _pakaiTemplate,
            style: FilledButton.styleFrom(
              backgroundColor: _warna,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Pakai Template Ini'),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          PlaceIcon(iconType: widget.place.ikon, color: _warna, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.place.nama,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2b2b2b),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Atur barang bawaan default untuk tempat ini.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF888888)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _barisBarang(Item item) {
    final dipilih = _terpilih.contains(item.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: dipilih
              ? _warna.withValues(alpha: 0.5)
              : const Color(0xFFe0e0e0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _toggle(item, !dipilih),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              PlaceIcon(
                iconType: item.ikon,
                color: dipilih ? _warna : const Color(0xFF2b2b2b),
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.nama,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2b2b2b),
                  ),
                ),
              ),
              Checkbox(
                value: dipilih,
                activeColor: _warna,
                onChanged: (value) => _toggle(item, value ?? false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TambahBarangDialog extends StatefulWidget {
  final Color warna;

  const _TambahBarangDialog({required this.warna});

  @override
  State<_TambahBarangDialog> createState() => _TambahBarangDialogState();
}

class _TambahBarangDialogState extends State<_TambahBarangDialog> {
  final _namaCtrl = TextEditingController();
  String _kategori = 'wajib';
  String _ikon = 'buku';

  @override
  void dispose() {
    _namaCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    final nama = _namaCtrl.text.trim();
    if (nama.isEmpty) return;

    Navigator.of(context).pop(
      Item(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        nama: nama,
        kategori: _kategori,
        ikon: _ikon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Barang',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2b2b2b),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _namaCtrl,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Nama barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kategori',
              style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _pilihanKategori('wajib'),
                const SizedBox(width: 8),
                _pilihanKategori('tambahan'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Ikon',
              style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _ikonBarang
                  .map(
                    (ikon) => InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => setState(() => _ikon = ikon),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _ikon == ikon
                                ? widget.warna
                                : const Color(0xFFe0e0e0),
                            width: _ikon == ikon ? 2 : 1,
                          ),
                        ),
                        child: PlaceIcon(
                          iconType: ikon,
                          color: _ikon == ikon
                              ? widget.warna
                              : const Color(0xFF888888),
                          size: 26,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: Color(0xFF555555)),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _simpan,
                  style: FilledButton.styleFrom(
                    backgroundColor: widget.warna,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pilihanKategori(String kategori) {
    final aktif = _kategori == kategori;
    return ChoiceChip(
      label: Text(kategori),
      selected: aktif,
      selectedColor: widget.warna.withValues(alpha: 0.15),
      onSelected: (_) => setState(() => _kategori = kategori),
    );
  }
}
