import 'package:flutter/material.dart';

/// Stub para plataformas mobile (iOS/Android)
/// Este arquivo é usado quando não está na web
class ScoreBatWebEmbed extends StatelessWidget {
  final String url;

  const ScoreBatWebEmbed({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    // Este widget nunca será usado em mobile, pois o código
    // principal usa WebView para iOS/Android
    return const Center(
      child: Text('Web embed não disponível nesta plataforma'),
    );
  }
}
