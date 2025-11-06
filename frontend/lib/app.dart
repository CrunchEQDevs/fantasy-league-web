// lib/app.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/monte_league.dart';
import 'screens/highlights_screen.dart';
import 'screens/game_the_week.dart';
import 'screens/injured_the_week.dart';
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TipFans - Fantasy League',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/monte_league ': (context) => const MonteLeagueScreen(),
        '/highlights': (context) => const HighlightsScreen(),
        '/game_the_week': (context) => const GameOfTheWeekScreen(),
        '/injured_the_week': (context) => const InjuredTheWeekScreen(),
      },
    );
  }
}
