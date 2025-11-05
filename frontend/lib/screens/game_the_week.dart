import 'package:flutter/material.dart';

class GameOfTheWeekScreen extends StatefulWidget {
  const GameOfTheWeekScreen({super.key});

  @override
  State<GameOfTheWeekScreen> createState() => _GameOfTheWeekScreenState();
}

class _GameOfTheWeekScreenState extends State<GameOfTheWeekScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game of the Week')),
      body: const Center(child: Text('Game of the Week Screen')),
    );
  }
}
