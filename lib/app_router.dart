import 'package:flutter/material.dart';
import 'screens/cek_sebelum_pergi.dart';
import 'screens/home.dart';
import 'screens/kelola_tempat.dart';
import 'screens/kunjungan_aktif.dart';
import 'screens/riwayat.dart';

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
        visit: (_) => const KunjunganAktifScreen(),
        check: (_) => const CekSebelumPergiScreen(),
        history: (_) => const RiwayatScreen(),
      };
}
