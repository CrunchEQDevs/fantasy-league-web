import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/highlights_widget.dart';

class HighlightsScreen extends StatelessWidget {
  const HighlightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          // Título da página
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: const Color.fromARGB(255, 1, 29, 57),
                ),
                const SizedBox(width: 8),
                const Text(
                  '⚽ Gols e Resultados',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 29, 57),
                  ),
                ),
              ],
            ),
          ),

          // Lista completa de highlights
          const Expanded(child: HighlightsWidget()),
        ],
      ),
    );
  }
}
