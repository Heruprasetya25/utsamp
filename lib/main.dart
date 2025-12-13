import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/profile_page.dart';
import 'screens/saran_page.dart';
import 'screens/product_page.dart';

void main() {
  runApp(const MplStyleApp());
}

class MplStyleApp extends StatelessWidget {
  const MplStyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark();
    return MaterialApp(
      title: 'Kaum Mendang Mending - MPL Style',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0F1A),
        colorScheme: base.colorScheme.copyWith(
          primary: const Color(0xFF7C3AED),
          secondary: const Color(0xFF38BDF8),
        ),
        textTheme: base.textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF0F1724),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/profile': (context) => const ProfilePage(),
        '/saran': (context) => const SaranPage(),
        '/produk': (context) => const ProductPage(),
      },
    );
  }
}
