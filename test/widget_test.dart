import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cek_tas/main.dart';

void main() {
  testWidgets('Home menampilkan judul dan tombol kunjungan', (tester) async {
    await tester.pumpWidget(const CekTasApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Cek Tas'), findsOneWidget);
    expect(find.textContaining('Hari ini'), findsOneWidget);
    expect(find.text('Mulai Kunjungan'), findsOneWidget);
  });

  testWidgets('Buka Kelola Tempat dari Home', (tester) async {
    await tester.pumpWidget(const CekTasApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.byTooltip('Kelola Tempat'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Kelola Tempat'), findsOneWidget);
    expect(find.text('Tambah Tempat'), findsOneWidget);
  });

  testWidgets('Home menampilkan kartu kunjungan kosong', (tester) async {
    await tester.pumpWidget(const CekTasApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.textContaining('Belum ada kunjungan aktif'), findsOneWidget);
  });

  testWidgets('Mulai Kunjungan tanpa tempat menampilkan pesan', (tester) async {
    await tester.pumpWidget(const CekTasApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('Mulai Kunjungan'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(
      find.text('Tambah tempat dulu di Kelola Tempat.'),
      findsOneWidget,
    );
  });

  testWidgets('Buka Riwayat dari Home', (tester) async {
    await tester.pumpWidget(const CekTasApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.byTooltip('Riwayat'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    expect(find.text('Riwayat'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
