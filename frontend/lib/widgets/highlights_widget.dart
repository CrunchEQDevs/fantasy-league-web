import 'package:flutter/material.dart';
import 'scorebat_embed_widget.dart';

/// Widget de Highlights usando o embed oficial do ScoreBat
/// Esta é a solução estável e mantida oficialmente pelo ScoreBat
///
/// O widget carrega o feed completo de jogos e highlights diretamente
/// do ScoreBat usando WebView, garantindo:
/// - Players de vídeo funcionando nativamente
/// - UI profissional e responsiva
/// - Atualizações automáticas
/// - Zero manutenção da nossa parte
///
/// Para obter seu próprio token personalizado, acesse:
/// https://www.scorebat.com/video-api/ (Widget Builder)
class HighlightsWidget extends StatelessWidget {
  final String? token;

  const HighlightsWidget({
    super.key,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return ScoreBatEmbedWidget(token: token);
  }
}
