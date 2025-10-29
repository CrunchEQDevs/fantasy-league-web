import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/hero.dart';
import '../widgets/buttom_home.dart';
import '../widgets/highlights_widget.dart';
import '../widgets/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 900;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: isWeb ? null : const CustomDrawer(), // Drawer apenas no mobile
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Widget Hero no topo
                  const HeroWidget(),

            LayoutBuilder(
              builder: (context, constraints) {
                // Altura responsiva baseada no tamanho da tela
                final screenWidth = MediaQuery.of(context).size.width;
                final isWeb = screenWidth > 600;
                final imageHeight = isWeb ? 350.0 : 180.0;

                return Container(
                  width: double.infinity,
                  height: imageHeight,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/imagem1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/imagem2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Botão Monte sua Equipa
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 70.0),
              child: BottomHome(
                text: 'Monte sua Equipa',
                onPressed: () {
                  Navigator.pushNamed(context, '/monte_league');
                },
                backgroundColor: const Color.fromARGB(255, 8, 92, 32),
                textColor: Colors.white,
              ),
            ),

            // Seção de Highlights
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título da seção
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '⚽ Gols e Resultados',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 1, 29, 57),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/highlights');
                        },
                        child: const Text(
                          'Ver todos',
                          style: TextStyle(
                            color: Color(0xFFED4F00),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Widget de Highlights com altura responsiva
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Calcula altura responsiva baseada no tamanho da tela
                      final screenWidth = MediaQuery.of(context).size.width;
                      final isWeb = screenWidth > 900;
                      final highlightHeight = isWeb ? 500.0 : 400.0;

                      return SizedBox(
                        width: constraints.maxWidth,
                        height: highlightHeight,
                        child: const HighlightsWidget(),
                      );
                    },
                  ),
                ],
              ),
            ),

                  const SizedBox(height: 40),
                  const WidgetFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}