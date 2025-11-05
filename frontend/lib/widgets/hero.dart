import 'package:flutter/material.dart';

class HeroWidget extends StatefulWidget {
  const HeroWidget({super.key});

  @override
  State<HeroWidget> createState() => _HeroWidgetState();
}

class _HeroWidgetState extends State<HeroWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 900;

    if (isWeb) {
      // Layout para Web
      return Container(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mostre que você entende do jogo',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Dê seus palpites e suba no ranking da TipFans League!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // Botão de ação
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/monte_league');
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Monte sua Liga'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFED4F00),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Layout para Mobile
      return Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mostre que você entende do jogo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Dê seus palpites e suba no ranking da TipFans League!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // Botão de ação
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/monte_league');
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Monte sua Liga'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFED4F00),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
