import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';
import 'saran_page.dart';

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
        useMaterial3: true,
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
      },
    );
  }
}
