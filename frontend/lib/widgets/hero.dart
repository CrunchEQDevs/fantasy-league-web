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
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/hero.png',
            height: 500,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/monte_league');
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Monte sua Equipa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFED4F00),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 430,
                    vertical: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {


      // Layout para Mobile - imagem depois botão
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/hero.png',
            height: 220,
            width: double.infinity,
            fit: BoxFit.contain,
          ),


          Padding(
            padding: const EdgeInsets.all(9.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/monte_league');
              },
              label: const Text('Monte sua Equipa'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFED4F00),
                  foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 130,
                  vertical: 0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
