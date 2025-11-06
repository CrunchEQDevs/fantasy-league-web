import 'package:flutter/material.dart';
import 'scorebat_embed_widget.dart';

/// Para obter seu próprio token personalizado, acesse:
/// https://www.scorebat.com/video-api/ (Widget Builder)
class HighlightsWidget extends StatelessWidget {
  final String? token;

  const HighlightsWidget({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return ScoreBatEmbedWidget(token: token);
  }
}
