import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final name = args?['name'] ?? 'User';
    final photo = args?['photo'] ?? 'assets/images/avatar.png';
    final banner = args?['banner'] ?? 'assets/images/banner.png';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0F1A), Color(0xFF0F1724)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                // top row: back/placeholder + profile avatar (centered style)
                Row(
                  children: [
                    // left empty for full-screen style
                    const SizedBox(width: 8),
                  ],
                ),

                const SizedBox(height: 8),

                // hero avatar + name
                CircleAvatar(
                  radius: 56,
                  backgroundColor: const Color(0xFF7C3AED).withOpacity(0.18),
                  backgroundImage: AssetImage(photo),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'kaum mendang mending',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),

                // banner card
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.45),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    banner,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 160,
                  ),
                ),
                const SizedBox(height: 18),

                // greeting + subtitle
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Halo, $name 👋',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Selamat datang kembali — cek profil atau kirim saran kamu.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 20),

                // neon-like menu grid (2 items)
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF7C3AED).withOpacity(0.14),
                    ),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _menuTile(context, Icons.person, 'Profil', () {
                        Navigator.pushNamed(
                          context,
                          '/profile',
                          arguments: args,
                        );
                      }),
                      _menuTile(
                        context,
                        Icons.feedback_outlined,
                        'Kotak Saran',
                        () {
                          Navigator.pushNamed(
                            context,
                            '/saran',
                            arguments: args,
                          );
                        },
                      ),
                      // filler/empty tile for alignment
                      Container(),
                    ],
                  ),
                ),

                const SizedBox(height: 26),
                // quick info / mini-cards
                Row(
                  children: [
                    Expanded(child: _infoCard('NPM', args?['npm'] ?? '-')),
                    const SizedBox(width: 12),
                    Expanded(child: _infoCard('Prodi', args?['prodi'] ?? '-')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _infoCard('Semester', args?['semester'] ?? '-'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: _infoCard('Universitas', 'PGRI Semarang')),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuTile(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF7C3AED), Color(0xFF38BDF8)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3AED).withOpacity(0.24),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 34, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
