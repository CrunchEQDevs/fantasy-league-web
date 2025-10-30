import 'package:flutter/material.dart';

class InjuredTheWeekScreen extends StatefulWidget {
  const InjuredTheWeekScreen({super.key});

  @override
  State<InjuredTheWeekScreen> createState() => _InjuredTheWeekScreenState();
}

class _InjuredTheWeekScreenState extends State<InjuredTheWeekScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Injured The Week'),
      ),
      body: const Center(
        child: Text('Lesionados da semana'),
      ),
    );
  }
}