import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: false, // evita cores automáticas.
      primaryColor: const Color(0xFF003366),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 1, 29, 57),
        foregroundColor: Colors.white,
      ),

      scaffoldBackgroundColor: Colors.white, // cor de fundo padrão do app

      textTheme: const TextTheme(
        // === H1 ===
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),

        // === H2 ===
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),

        // === H3 ===
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),

        // === Parágrafo (p) ===
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.4, // melhora a leitura
        ),
      ),
    );
  }
}
