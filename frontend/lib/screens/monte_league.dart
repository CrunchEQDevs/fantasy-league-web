import 'package:flutter/material.dart';

class MonteLeagueScreen extends StatefulWidget {
  const MonteLeagueScreen({super.key});

  @override
  State<MonteLeagueScreen> createState() => _MonteLeagueScreenState();
}

class _MonteLeagueScreenState extends State<MonteLeagueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monte sua League'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tela para montar a league'),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navega de volta para a tela anterior
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
