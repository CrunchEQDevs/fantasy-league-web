import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    this.title = 'Fantasy League',
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 900;

    if (isWeb) {
      // AppBar para Web - com navbar horizontal
      return AppBar(
        automaticallyImplyLeading: false, // Remove o ícone do drawer
        title: Row(
          children: [
            // Logo à esquerda
            Image.asset(
              'assets/logo.png',
              height: 32,
            ),
            const SizedBox(width: 12),
            const Text(
              'Fantasy League',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            // Links de navegação no centro/direita
            _buildNavLink(context, 'Premier League', '/premier-league', Icons.sports_soccer),
            const SizedBox(width: 24),
            _buildNavLink(context, 'La Liga', '/la-liga', Icons.sports_soccer),
            const SizedBox(width: 24),
            _buildNavLink(context, 'Brasileirão', '/brasileirao', Icons.sports_soccer),
            const SizedBox(width: 32),
            // Botão de ação
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/monte_league');
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Monte sua Liga'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFED4F00),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      );
    } else {
      // AppBar para Mobile - com drawer
      return AppBar(
        title: Text(title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png',
              height: 20,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildNavLink(BuildContext context, String label, String route, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: const Color(0xFFED4F00)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
