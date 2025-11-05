import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'dart:ui';

/// ======= PALETA "EMERALD STADIUM" =======
const kBgTop = Color(0xFF0B1E1A); // fundo geral topo (stadium)
const kBgBottom = Color(0xFF071614); // fundo geral base
const kPitchDeep = Color(0xFF0A3A2A); // verde mais escuro
const kPitchMid = Color(0xFF0E6C4C); // verde médio
const kPitchLite = Color(0xFF11A874); // reflexo esmeralda
const kNeonMint = Color(0xFF00FFB1); // acento neon
const kNeonMint2 = Color(0xFF00E39A);
const kChalkWhite = Color(0xFFFFFFFF);

void main() => runApp(const FantasyProApp());

class FantasyProApp extends StatelessWidget {
  const FantasyProApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantasy Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBgBottom,
        colorScheme: const ColorScheme.dark(
          primary: kNeonMint,
          secondary: kNeonMint2,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const PremiumFieldScreen(),
    );
  }
}

class PremiumFieldScreen extends StatefulWidget {
  const PremiumFieldScreen({super.key});
  @override
  State<PremiumFieldScreen> createState() => _PremiumFieldScreenState();
}

/// Payload de drag
class DragData {
  final bool isBench;
  final int index;
  final String? name;
  DragData({required this.isBench, required this.index, required this.name});
}

class _PremiumFieldScreenState extends State<PremiumFieldScreen> {
  final Map<int, String> players = {}; // index -> nome (campo)
  final Map<int, String> benchPlayers = {}; // 0..3 -> nome (banco)
  bool tilt3D = true;

  // Opcional: textura do campo (deixe null para usar o "verde top" abaixo)
  final String? pitchImageAsset = null; // ex.: 'assets/pitch_texture.jpg'
  final String? pitchImageUrl = null;

  // Formação 4-3-3
  final formation = const [
    Offset(0.5, 0.90), // GK
    Offset(0.18, 0.74),
    Offset(0.40, 0.69),
    Offset(0.60, 0.69),
    Offset(0.82, 0.74),
    Offset(0.26, 0.50),
    Offset(0.50, 0.46),
    Offset(0.74, 0.50),
    Offset(0.36, 0.30),
    Offset(0.64, 0.30),
    Offset(0.50, 0.14),
  ];

  final availablePlayers = const [
    'Messi',
    'Lorenzo',
    'Rodrigo',
    'Januário',
    'Vinícius Jr',
    'Fábio',
    'Nilo',
    'William',
    'Aires',
    'Adriano',
    'Eduardo',
    'Cristiano Ronaldo',
    'Neymar',
    'Mbappé',
    'Haaland',
    'De Bruyne',
    'Modrić',
    'Bellingham',
  ];

  void _openPlayerSelect({required bool isBench, required int index}) async {
    final chosen = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: kBgTop,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            expand: false,
            builder: (ctx, scrollCtrl) {
              return Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isBench ? 'Selecionar reserva' : 'Selecionar jogador',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollCtrl,
                      itemCount: availablePlayers.length,
                      itemBuilder: (context, i) {
                        final p = availablePlayers[i];
                        return ListTile(
                          leading: SvgPicture.asset(
                            'assets/shirt_white.svg',
                            width: 40,
                            placeholderBuilder: (context) =>
                                const Icon(Icons.person, size: 30),
                          ),
                          title: Text(
                            p,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => Navigator.pop(context, p),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    if (chosen != null) {
      setState(() {
        if (isBench) {
          benchPlayers[index] = chosen;
        } else {
          players[index] = chosen;
        }
      });
    }
  }

  ImageProvider? get _pitchImage {
    if (pitchImageUrl != null && pitchImageUrl!.isNotEmpty)
      return NetworkImage(pitchImageUrl!);
    if (pitchImageAsset != null && pitchImageAsset!.isNotEmpty)
      return AssetImage(pitchImageAsset!);
    return null;
  }

  void _applyDrop(
    DragData data, {
    required bool toBench,
    required int targetIndex,
  }) {
    setState(() {
      if (data.isBench && toBench) {
        final a = benchPlayers[data.index];
        final b = benchPlayers[targetIndex];
        if (a == null && b == null) return;
        benchPlayers[targetIndex] = a ?? '';
        if (b != null) {
          benchPlayers[data.index] = b;
        } else {
          benchPlayers.remove(data.index);
        }
      } else if (!data.isBench && !toBench) {
        final a = players[data.index];
        final b = players[targetIndex];
        if (a == null && b == null) return;
        players[targetIndex] = a ?? '';
        if (b != null) {
          players[data.index] = b;
        } else {
          players.remove(data.index);
        }
      } else if (data.isBench && !toBench) {
        final incoming = benchPlayers[data.index];
        final replaced = players[targetIndex];
        if (incoming == null) return;
        players[targetIndex] = incoming;
        if (replaced != null) {
          benchPlayers[data.index] = replaced;
        } else {
          benchPlayers.remove(data.index);
        }
      } else {
        final incoming = players[data.index];
        final replaced = benchPlayers[targetIndex];
        if (incoming == null) return;
        benchPlayers[targetIndex] = incoming;
        if (replaced != null) {
          players[data.index] = replaced;
        } else {
          players.remove(data.index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _ = MediaQuery.of(context).padding.top;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    final field = _Field(
      formation: formation,
      players: players,
      onTapSpot: (i) => _openPlayerSelect(isBench: false, index: i),
      onDrop: (drag, targetIndex) =>
          _applyDrop(drag, toBench: false, targetIndex: targetIndex),
      pitchImage: _pitchImage,
      tilt3D: tilt3D,
    );

    return Container(
      // Fundo geral com gradiente + vinheta
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kBgTop, kBgBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Fantasy Premium'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.white.withValues(alpha: 0.03)),
            ),
          ),
          actions: [
            Row(
              children: [
                const Text(
                  '3D',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                Switch(
                  value: tilt3D,
                  onChanged: (v) => setState(() => tilt3D = v),
                  activeThumbColor: kNeonMint,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: bottomPad > 0 ? bottomPad : 6,
          ), // evita overflow 1px
          child: Column(
            children: [
              // Campo
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: field,
                ),
              ),
              // Banco (4 reservas) — vidro fosco com brilho sutil
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  6,
                  16,
                  12 + (bottomPad > 0 ? bottomPad / 2 : 4),
                ),
                child: _BenchBar(
                  benchPlayers: benchPlayers,
                  onTapBench: (i) => _openPlayerSelect(isBench: true, index: i),
                  onDrop: (drag, targetIndex) =>
                      _applyDrop(drag, toBench: true, targetIndex: targetIndex),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =========================== FIELD ===========================
class _Field extends StatelessWidget {
  const _Field({
    required this.formation,
    required this.players,
    required this.onTapSpot,
    required this.onDrop,
    required this.pitchImage,
    required this.tilt3D,
  });

  final List<Offset> formation;
  final Map<int, String> players;
  final void Function(int index) onTapSpot;
  final void Function(DragData data, int targetIndex) onDrop;
  final ImageProvider? pitchImage;
  final bool tilt3D;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;

        Widget core = Stack(
          children: [
            // Fundo do campo: verde moderno OU textura
            Container(
              decoration: BoxDecoration(
                gradient: pitchImage == null
                    ? const LinearGradient(
                        colors: [kPitchMid, kPitchDeep],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                image: pitchImage != null
                    ? DecorationImage(
                        image: pitchImage!,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.10),
                          BlendMode.darken,
                        ),
                      )
                    : null,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.45),
                    blurRadius: 26,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
            ),

            // Vinheta de estádio
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.5),
                      radius: 1.4,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.18),
                      ],
                      stops: const [0.65, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            // Faixas da grama
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _StripesPainter()),
              ),
            ),

            // Linhas, áreas, cantos e pontos
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: CustomPaint(
                size: Size(w, h),
                painter: PremiumPitchPainter(),
              ),
            ),

            // Reflexo diagonal (luz de estádio)
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.06),
                        Colors.transparent,
                        Colors.white.withValues(alpha: 0.05),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Spots dos jogadores
            ...List.generate(formation.length, (i) {
              final pos = formation[i];
              final name = players[i];
              return Positioned(
                left: w * pos.dx - 28,
                top: h * pos.dy - 28,
                child: _DraggableShirt(
                  name: name,
                  onTap: () => onTapSpot(i),
                  data: DragData(isBench: false, index: i, name: name),
                  child: _SpotShirt(name: name),
                  onAccept: (drag) => onDrop(drag, i),
                ),
              );
            }),
          ],
        );

        // Moldura
        core = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.04),
                Colors.white.withValues(alpha: 0.012),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: core,
          ),
        );

        // Perspectiva 3D opcional
        if (tilt3D) {
          core = Transform(
            alignment: Alignment.topCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0013)
              ..rotateX(-math.pi / 9),
            child: core,
          );
        }

        return core;
      },
    );
  }
}

/// =========================== BENCH ===========================
class _BenchBar extends StatelessWidget {
  const _BenchBar({
    required this.benchPlayers,
    required this.onTapBench,
    required this.onDrop,
  });

  final Map<int, String> benchPlayers;
  final void Function(int index) onTapBench;
  final void Function(DragData data, int targetIndex) onDrop;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // vidro fosco
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.06),
                  Colors.white.withValues(alpha: 0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: const SizedBox(),
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (i) {
                final name = benchPlayers[i];
                return _DraggableShirt(
                  name: name,
                  onTap: () => onTapBench(i),
                  data: DragData(isBench: true, index: i, name: name),
                  child: _BenchSpot(name: name),
                  onAccept: (drag) => onDrop(drag, i),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================== SHIRT / DRAG ===========================
class _DraggableShirt extends StatelessWidget {
  const _DraggableShirt({
    required this.name,
    required this.onTap,
    required this.data,
    required this.child,
    required this.onAccept,
  });

  final String? name;
  final VoidCallback onTap;
  final DragData data;
  final Widget child;
  final void Function(DragData dragData) onAccept;

  @override
  Widget build(BuildContext context) {
    final body = GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: child,
    );

    final draggable = name != null
        ? Draggable<DragData>(
            data: data,
            maxSimultaneousDrags: 1,
            dragAnchorStrategy: pointerDragAnchorStrategy,
            feedback: Opacity(
              opacity: 0.95,
              child: _ShirtIcon(selected: true, size: 60),
            ),
            childWhenDragging: Opacity(opacity: 0.3, child: body),
            onDragStarted: () => HapticFeedback.selectionClick(),
            child: body,
          )
        : body;

    return DragTarget<DragData>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidate, rejected) {
        final hovering = candidate.isNotEmpty;
        return AnimatedScale(
          duration: const Duration(milliseconds: 110),
          scale: hovering ? 1.08 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 110),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: hovering
                  ? [
                      BoxShadow(
                        color: kNeonMint.withValues(alpha: 0.55),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: draggable,
          ),
        );
      },
    );
  }
}

class _ShirtIcon extends StatelessWidget {
  const _ShirtIcon({required this.selected, this.size = 56});
  final bool selected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (selected)
          Container(
            width: size + 8,
            height: size + 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kNeonMint.withValues(alpha: 0.45),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        SvgPicture.asset(
          selected ? 'assets/shirt_selected.svg' : 'assets/shirt_white.svg',
          width: size,
          placeholderBuilder: (context) => Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: selected ? kNeonMint : Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.sports_soccer,
              size: 28,
              color: Colors.black87,
            ),
          ),
        ),
        if (!selected) const Icon(Icons.add, size: 24, color: Colors.black54),
      ],
    );
  }
}

class _SpotShirt extends StatelessWidget {
  const _SpotShirt({required this.name});
  final String? name;

  @override
  Widget build(BuildContext context) {
    final selected = name != null;
    return Column(
      children: [
        _ShirtIcon(selected: selected),
        const SizedBox(height: 4),
        if (selected)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.38),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Text(
              name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                color: Colors.white, // nunca cinza apagado sobre o verde
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _BenchSpot extends StatelessWidget {
  const _BenchSpot({required this.name});
  final String? name;

  @override
  Widget build(BuildContext context) {
    final selected = name != null;
    return Column(
      children: [
        _ShirtIcon(selected: selected, size: 44),
        const SizedBox(height: 2),
        Container(
          width: 62,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: selected ? 0.35 : 0.22),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
          ),
          child: Text(
            name ?? 'Reserva',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              color: Colors.white.withValues(alpha: selected ? 1.0 : 0.85),
            ),
          ),
        ),
      ],
    );
  }
}

/// =========================== PAINTERS ===========================

class _StripesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Alternância de faixas sutil
    final stripeDark = Paint()
      ..shader = LinearGradient(
        colors: [kPitchDeep.withValues(alpha: 0.22), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    for (int i = 0; i < 14; i++) {
      final top = i * size.height / 14;
      final rect = Rect.fromLTWH(0, top, size.width, size.height / 28);
      canvas.drawRect(rect, stripeDark);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PremiumPitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const inset = 18.0;
    final field = Rect.fromLTWH(
      inset,
      inset,
      size.width - inset * 2,
      size.height - inset * 2,
    );

    final glow = Paint()
      ..color = kChalkWhite.withValues(alpha: 0.38)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    final line = Paint()
      ..color = kChalkWhite.withValues(alpha: 0.97)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final dot = Paint()..color = kChalkWhite.withValues(alpha: 0.95);

    // Bordas
    canvas.drawRect(field, glow);
    canvas.drawRect(field, line);

    // Linha do meio e círculo
    final midY = size.height / 2;
    canvas.drawLine(
      Offset(inset, midY),
      Offset(size.width - inset, midY),
      glow,
    );
    canvas.drawLine(
      Offset(inset, midY),
      Offset(size.width - inset, midY),
      line,
    );
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 50, glow);
    canvas.drawCircle(center, 50, line);
    canvas.drawCircle(center, 2.5, dot);

    // Grandes áreas
    final areaW = size.width * 0.60;
    const areaH = 102.0;
    final topArea = Rect.fromCenter(
      center: Offset(size.width / 2, inset + areaH / 2),
      width: areaW,
      height: areaH,
    );
    final botArea = Rect.fromCenter(
      center: Offset(size.width / 2, size.height - inset - areaH / 2),
      width: areaW,
      height: areaH,
    );
    for (final r in [topArea, botArea]) {
      canvas.drawRect(r, glow);
      canvas.drawRect(r, line);
    }

    // Pequenas áreas
    final smallW = size.width * 0.35;
    const smallH = 60.0;
    final topSmall = Rect.fromCenter(
      center: Offset(size.width / 2, inset + smallH / 2),
      width: smallW,
      height: smallH,
    );
    final botSmall = Rect.fromCenter(
      center: Offset(size.width / 2, size.height - inset - smallH / 2),
      width: smallW,
      height: smallH,
    );
    for (final r in [topSmall, botSmall]) {
      canvas.drawRect(r, glow);
      canvas.drawRect(r, line);
    }

    // Pontos de pênalti
    final topPk = Offset(size.width / 2, inset + areaH - 12);
    final botPk = Offset(size.width / 2, size.height - inset - areaH + 12);
    canvas.drawCircle(topPk, 2.2, dot);
    canvas.drawCircle(botPk, 2.2, dot);

    // Glow leve no centro
    final centerFill = Paint()
      ..shader = RadialGradient(
        colors: [Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: 32));
    canvas.drawCircle(center, 32, centerFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
