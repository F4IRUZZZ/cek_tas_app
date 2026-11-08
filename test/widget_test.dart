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
}
