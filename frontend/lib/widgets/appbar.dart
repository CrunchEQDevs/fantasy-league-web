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
    final isLargeScreen = screenWidth > 1400; // Telas grandes (desktop)
    final isMediumScreen = screenWidth > 900 && screenWidth <= 1400; // Telas médias

    if (isWeb) {
      // AppBar para Web - com navbar horizontal
      return AppBar(
        automaticallyImplyLeading: false,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Logo à esquerda
              Image.asset(
                'assets/logo.png',
                height: 32,
              ),
              SizedBox(width: isLargeScreen ? 12 : 8),
              Text(
                'Fantasy League',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isLargeScreen ? 20 : 18,
                ),
              ),
              SizedBox(width: isLargeScreen ? 40 : 20),

              // Links de navegação - Ligas
              _buildNavLink(
                context,
                isLargeScreen ? 'Premier League' : 'Premier',
                '/',
                Icons.sports_soccer,
                showLabel: isLargeScreen || isMediumScreen,
              ),
              SizedBox(width: isLargeScreen ? 24 : 16),
              _buildNavLink(
                context,
                isLargeScreen ? 'La Liga' : 'La Liga',
                '/',
                Icons.sports_soccer,
                showLabel: isLargeScreen || isMediumScreen,
              ),
              SizedBox(width: isLargeScreen ? 24 : 16),
              _buildNavLink(
                context,
                isLargeScreen ? 'Brasileirão' : 'Brasileiro',
                '/',
                Icons.sports_soccer,
                showLabel: isLargeScreen || isMediumScreen,
              ),
              SizedBox(width: isLargeScreen ? 32 : 20),

              // Botão de ação
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/monte_league');
                },
                icon: const Icon(Icons.add, size: 18),
                label: Text(
                  isLargeScreen ? 'Monte sua Liga' : 'Monte Liga',
                  style: TextStyle(fontSize: isLargeScreen ? 14 : 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFED4F00),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 20 : 12,
                    vertical: isLargeScreen ? 12 : 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(width: isLargeScreen ? 24 : 16),

              // Jogos da semana
              _buildNavLink(
                context,
                isLargeScreen ? 'Jogos da semana' : 'Jogos',
                '/game_the_week',
                Icons.sports_soccer,
                showLabel: true,
              ),
              SizedBox(width: isLargeScreen ? 24 : 16),

              // Lesionados da semana
              _buildNavLink(
                context,
                isLargeScreen ? 'Lesionados' : 'Lesões',
                '/injured_the_week',
                Icons.assist_walker_rounded,
                showLabel: true,
              ),
              SizedBox(width: isLargeScreen ? 32 : 20),

              // Login
              _buildNavLink(
                context,
                'Login',
                '/',
                Icons.account_circle_outlined,
                showLabel: isLargeScreen,
              ),
              SizedBox(width: isLargeScreen ? 16 : 12),

              // Criar conta
              _buildNavLink(
                context,
                isLargeScreen ? 'Criar conta' : 'Criar',
                '/',
                Icons.person_add,
                showLabel: isLargeScreen,
              ),
              const SizedBox(width: 16),
            ],
          ),
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

  Widget _buildNavLink(
    BuildContext context,
    String label,
    String route,
    IconData icon, {
    bool showLabel = true,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: const Color(0xFFED4F00)),
            if (showLabel) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
