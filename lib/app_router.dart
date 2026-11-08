import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/kelola_tempat.dart';

class AppRouter {
  static const home = '/';
  static const places = '/places';
  static const template = '/template';
  static const visit = '/visit';
  static const check = '/check';
  static const history = '/history';

  static Map<String, WidgetBuilder> get routes => {
        home: (_) => const HomeScreen(),
        places: (_) => const KelolaTempatScreen(),
        template: (_) => const _PlaceholderScreen(title: 'Template'),
        visit: (_) => const _PlaceholderScreen(title: 'Kunjungan'),
        check: (_) => const _PlaceholderScreen(title: 'Cek Sebelum Pergi'),
        history: (_) => const _PlaceholderScreen(title: 'Riwayat'),
      };
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Center(
        child: Text(
          '$title akan tersedia di fase berikutnya.',
          style: const TextStyle(color: Color(0xFF888888)),
        ),
      ),
    );
  }
}
