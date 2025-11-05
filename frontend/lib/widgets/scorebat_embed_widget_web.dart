import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;

/// Widget específico para web que renderiza o embed do ScoreBat usando iframe
class ScoreBatWebEmbed extends StatefulWidget {
  final String url;

  const ScoreBatWebEmbed({super.key, required this.url});

  @override
  State<ScoreBatWebEmbed> createState() => _ScoreBatWebEmbedState();
}

class _ScoreBatWebEmbedState extends State<ScoreBatWebEmbed> {
  static int _nextViewId = 0;
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'scorebat-embed-${_nextViewId++}';
    _registerViewFactory();
  }

  void _registerViewFactory() {
    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final iframe =
          web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.src = widget.url;
      iframe.style.border = 'none';
      iframe.style.height = '100%';
      iframe.style.width = '100%';
      iframe.setAttribute('allowfullscreen', 'true');
      iframe.setAttribute('allow', 'autoplay; fullscreen');

      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
