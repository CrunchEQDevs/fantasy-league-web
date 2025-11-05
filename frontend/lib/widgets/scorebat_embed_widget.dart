import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'scorebat_embed_widget_web.dart'
    if (dart.library.io) 'scorebat_embed_widget_stub.dart';

/// Widget que carrega o feed oficial do ScoreBat usando embed
/// Esta é a solução oficial e mantida pelo ScoreBat
/// Suporta iOS, Android e Web
class ScoreBatEmbedWidget extends StatefulWidget {
  final String? token;

  const ScoreBatEmbedWidget({super.key, this.token});

  @override
  State<ScoreBatEmbedWidget> createState() => _ScoreBatEmbedWidgetState();
}

class _ScoreBatEmbedWidgetState extends State<ScoreBatEmbedWidget> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  late final String _embedUrl;

  @override
  void initState() {
    super.initState();

    // Token padrão fornecido pelo ScoreBat Widget Builder
    // Você pode gerar seu próprio token em: https://www.scorebat.com/video-api/
    final token =
        widget.token ??
        'MjQ4OTg0XzE3NjE3MjkxMzRfNmE2MWE5NDBhNTFkNjJhZGZlZjdjZjBiYjcxMDVkM2EyN2JjMWYyOA==';

    _embedUrl = 'https://www.scorebat.com/embed/videofeed/?token=$token';

    if (!kIsWeb) {
      _initializeWebView();
    }
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _hasError = true;
                _errorMessage = error.description;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(_embedUrl));
  }

  @override
  Widget build(BuildContext context) {
    // Para web, usar widget específico
    if (kIsWeb) {
      return ScoreBatWebEmbed(url: _embedUrl);
    }

    // Para mobile (iOS/Android), usar WebView
    return Stack(
      children: [
        WebViewWidget(controller: _controller),

        // Loading indicator
        if (_isLoading)
          Container(
            color: Colors.white,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Carregando jogos...'),
                ],
              ),
            ),
          ),

        // Error display
        if (_hasError)
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar jogos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = false;
                        _isLoading = true;
                      });
                      _controller.reload();
                    },
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
