import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'providers/item_provider.dart';
import 'providers/place_provider.dart';
import 'providers/visit_provider.dart';

void main() {
  runApp(const CekTasApp());
}

class CekTasApp extends StatelessWidget {
  const CekTasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlaceProvider()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (_) => VisitProvider()),
      ],
      child: MaterialApp(
        title: 'Cek Tas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2b2b2b),
          ),
          scaffoldBackgroundColor: const Color(0xFFf4f4f4),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF2b2b2b),
            elevation: 0,
            centerTitle: false,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFc0392b),
            foregroundColor: Colors.white,
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        initialRoute: AppRouter.home,
        routes: AppRouter.routes,
      ),
    );
  }
}
