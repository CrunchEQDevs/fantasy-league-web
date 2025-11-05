import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'dart:ui';

/// ======= PALETA "EMERALD STADIUM" =======
const kBgTop = Color(0xFF0B1E1A);
const kBgBottom = Color(0xFF071614);
const kPitchDeep = Color(0xFF0A3A2A);
const kPitchMid = Color(0xFF0E6C4C);
const kPitchLite = Color(0xFF11A874);
const kNeonMint = Color(0xFF00FFB1);
const kNeonMint2 = Color(0xFF00E39A);
const kChalkWhite = Color(0xFFFFFFFF);

/// Payload de drag
class DragData {
  final bool isBench;
  final int index;
  final String? name;
  DragData({required this.isBench, required this.index, required this.name});
}

/// Widget adaptativo que escolhe a melhor versão baseado na plataforma
class CampoAdaptativo extends StatelessWidget {
  final Map<int, String> players;
  final Map<int, String> benchPlayers;
  final List<Offset> formation;
  final void Function({required bool isBench, required int index})
  onPlayerSelect;
  final void Function(DragData data, bool toBench, int targetIndex) onDrop;
  final ImageProvider? pitchImage;
  final bool tilt3D;

  const CampoAdaptativo({
    super.key,
    required this.players,
    required this.benchPlayers,
    required this.formation,
    required this.onPlayerSelect,
    required this.onDrop,
    this.pitchImage,
    required this.tilt3D,
  });

  @override
  Widget build(BuildContext context) {
    // Detecta se é web E se tem tela grande
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 800;

        if (kIsWeb && isLargeScreen) {
          return CampoWebWidget(
            players: players,
            benchPlayers: benchPlayers,
            formation: formation,
            onPlayerSelect: onPlayerSelect,
            onDrop: onDrop,
            pitchImage: pitchImage,
            tilt3D: tilt3D,
          );
        } else {
          return CampoMobileWidget(
            players: players,
            benchPlayers: benchPlayers,
            formation: formation,
            onPlayerSelect: onPlayerSelect,
            onDrop: onDrop,
            pitchImage: pitchImage,
            tilt3D: tilt3D,
          );
        }
      },
    );
  }
}

/// Versão WEB otimizada - horizontal, hover states, melhor uso do espaço
class CampoWebWidget extends StatelessWidget {
  final Map<int, String> players;
  final Map<int, String> benchPlayers;
  final List<Offset> formation;
  final void Function({required bool isBench, required int index})
  onPlayerSelect;
  final void Function(DragData data, bool toBench, int targetIndex) onDrop;
  final ImageProvider? pitchImage;
  final bool tilt3D;

  const CampoWebWidget({
    super.key,
    required this.players,
    required this.benchPlayers,
    required this.formation,
    required this.onPlayerSelect,
    required this.onDrop,
    this.pitchImage,
    required this.tilt3D,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Campo (ocupa maior parte)
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _FieldWeb(
              formation: formation,
              players: players,
              onTapSpot: (i) => onPlayerSelect(isBench: false, index: i),
              onDrop: (drag, targetIndex) => onDrop(drag, false, targetIndex),
              pitchImage: pitchImage,
              tilt3D: tilt3D,
            ),
          ),
        ),
        // Banco (sidebar direita)
        SizedBox(
          width: 200,
          child: _BenchSidebarWeb(
            benchPlayers: benchPlayers,
            onTapBench: (i) => onPlayerSelect(isBench: true, index: i),
            onDrop: (drag, targetIndex) => onDrop(drag, true, targetIndex),
          ),
        ),
      ],
    );
  }
}

/// Versão MOBILE - mantém o design original vertical
class CampoMobileWidget extends StatelessWidget {
  final Map<int, String> players;
  final Map<int, String> benchPlayers;
  final List<Offset> formation;
  final void Function({required bool isBench, required int index})
  onPlayerSelect;
  final void Function(DragData data, bool toBench, int targetIndex) onDrop;
  final ImageProvider? pitchImage;
  final bool tilt3D;

  const CampoMobileWidget({
    super.key,
    required this.players,
    required this.benchPlayers,
    required this.formation,
    required this.onPlayerSelect,
    required this.onDrop,
    this.pitchImage,
    required this.tilt3D,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Column(
      children: [
        // Campo
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: _FieldMobile(
              formation: formation,
              players: players,
              onTapSpot: (i) => onPlayerSelect(isBench: false, index: i),
              onDrop: (drag, targetIndex) => onDrop(drag, false, targetIndex),
              pitchImage: pitchImage,
              tilt3D: tilt3D,
            ),
          ),
        ),
        // Banco (horizontal na base)
        Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            6,
            16,
            12 + (bottomPad > 0 ? bottomPad / 2 : 4),
          ),
          child: _BenchBarMobile(
            benchPlayers: benchPlayers,
            onTapBench: (i) => onPlayerSelect(isBench: true, index: i),
            onDrop: (drag, targetIndex) => onDrop(drag, true, targetIndex),
          ),
        ),
      ],
    );
  }
}

/// =========================== FIELD WEB ===========================
class _FieldWeb extends StatelessWidget {
  const _FieldWeb({
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

        Widget core = MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Stack(
            children: [
              // Fundo do campo
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
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.45),
                      blurRadius: 30,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
              ),

              // Vinheta
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, -0.5),
                        radius: 1.4,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.15),
                        ],
                        stops: const [0.70, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),

              // Faixas
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(painter: _StripesPainter()),
                ),
              ),

              // Linhas do campo
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CustomPaint(
                  size: Size(w, h),
                  painter: PremiumPitchPainter(),
                ),
              ),

              // Reflexo
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.08),
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.06),
                        ],
                        stops: const [0.0, 0.55, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // Jogadores com hover effect
              ...List.generate(formation.length, (i) {
                final pos = formation[i];
                final name = players[i];
                return Positioned(
                  left: w * pos.dx - 32,
                  top: h * pos.dy - 32,
                  child: _DraggableShirtWeb(
                    name: name,
                    onTap: () => onTapSpot(i),
                    data: DragData(isBench: false, index: i, name: name),
                    onAccept: (drag) => onDrop(drag, i),
                  ),
                );
              }),
            ],
          ),
        );

        // Moldura
        core = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
              width: 1.5,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.05),
                Colors.white.withValues(alpha: 0.015),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: core,
          ),
        );

        // Perspectiva 3D opcional (mais sutil na web)
        if (tilt3D) {
          core = Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-math.pi / 16), // menos agressivo que mobile
            child: core,
          );
        }

        return core;
      },
    );
  }
}

/// =========================== FIELD MOBILE ===========================
class _FieldMobile extends StatelessWidget {
  const _FieldMobile({
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
            // Fundo do campo
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

            // Vinheta
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

            // Faixas
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _StripesPainter()),
              ),
            ),

            // Linhas
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: CustomPaint(
                size: Size(w, h),
                painter: PremiumPitchPainter(),
              ),
            ),

            // Reflexo
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

            // Jogadores
            ...List.generate(formation.length, (i) {
              final pos = formation[i];
              final name = players[i];
              return Positioned(
                left: w * pos.dx - 28,
                top: h * pos.dy - 28,
                child: _DraggableShirtMobile(
                  name: name,
                  onTap: () => onTapSpot(i),
                  data: DragData(isBench: false, index: i, name: name),
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

        // Perspectiva 3D
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

/// =========================== BENCH WEB (SIDEBAR) ===========================
class _BenchSidebarWeb extends StatelessWidget {
  const _BenchSidebarWeb({
    required this.benchPlayers,
    required this.onTapBench,
    required this.onDrop,
  });

  final Map<int, String> benchPlayers;
  final void Function(int index) onTapBench;
  final void Function(DragData data, int targetIndex) onDrop;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.08),
            Colors.white.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(-5, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.event_seat, color: kNeonMint, size: 32),
                const SizedBox(height: 8),
                const Text(
                  'BANCO',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
                const Divider(height: 24, color: Colors.white24),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, i) {
                      final name = benchPlayers[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _DraggableShirtWeb(
                          name: name,
                          onTap: () => onTapBench(i),
                          data: DragData(isBench: true, index: i, name: name),
                          onAccept: (drag) => onDrop(drag, i),
                          isVertical: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// =========================== BENCH MOBILE (BAR) ===========================
class _BenchBarMobile extends StatelessWidget {
  const _BenchBarMobile({
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
                return _DraggableShirtMobile(
                  name: name,
                  onTap: () => onTapBench(i),
                  data: DragData(isBench: true, index: i, name: name),
                  onAccept: (drag) => onDrop(drag, i),
                  isBench: true,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================== DRAGGABLE WEB ===========================
class _DraggableShirtWeb extends StatefulWidget {
  const _DraggableShirtWeb({
    required this.name,
    required this.onTap,
    required this.data,
    required this.onAccept,
    this.isVertical = false,
  });

  final String? name;
  final VoidCallback onTap;
  final DragData data;
  final void Function(DragData dragData) onAccept;
  final bool isVertical;

  @override
  State<_DraggableShirtWeb> createState() => _DraggableShirtWebState();
}

class _DraggableShirtWebState extends State<_DraggableShirtWeb> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.name != null;

    Widget content = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          scale: _isHovered ? 1.1 : 1.0,
          child: widget.isVertical
              ? _BenchSpotWeb(name: widget.name, isHovered: _isHovered)
              : _FieldSpotWeb(name: widget.name, isHovered: _isHovered),
        ),
      ),
    );

    // Drag só se tiver jogador
    if (selected) {
      content = Draggable<DragData>(
        data: widget.data,
        maxSimultaneousDrags: 1,
        dragAnchorStrategy: pointerDragAnchorStrategy,
        feedback: Opacity(
          opacity: 0.9,
          child: _ShirtIcon(selected: true, size: 70),
        ),
        childWhenDragging: Opacity(opacity: 0.3, child: content),
        child: content,
      );
    }

    return DragTarget<DragData>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (details) => widget.onAccept(details.data),
      builder: (context, candidate, rejected) {
        final dropping = candidate.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: widget.isVertical ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: widget.isVertical ? BorderRadius.circular(16) : null,
            border: dropping ? Border.all(color: kNeonMint, width: 3) : null,
            boxShadow: dropping
                ? [
                    BoxShadow(
                      color: kNeonMint.withValues(alpha: 0.6),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: content,
        );
      },
    );
  }
}

/// =========================== DRAGGABLE MOBILE ===========================
class _DraggableShirtMobile extends StatelessWidget {
  const _DraggableShirtMobile({
    required this.name,
    required this.onTap,
    required this.data,
    required this.onAccept,
    this.isBench = false,
  });

  final String? name;
  final VoidCallback onTap;
  final DragData data;
  final void Function(DragData dragData) onAccept;
  final bool isBench;

  @override
  Widget build(BuildContext context) {
    final body = GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: isBench
          ? _BenchSpotMobile(name: name)
          : _FieldSpotMobile(name: name),
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

/// =========================== SHIRT SPOTS WEB ===========================
class _FieldSpotWeb extends StatelessWidget {
  const _FieldSpotWeb({required this.name, required this.isHovered});
  final String? name;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final selected = name != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ShirtIcon(selected: selected, size: 64),
        const SizedBox(height: 6),
        if (selected)
          Container(
            constraints: const BoxConstraints(maxWidth: 120),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isHovered
                  ? kNeonMint.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered
                    ? kNeonMint
                    : Colors.white.withValues(alpha: 0.10),
                width: isHovered ? 2 : 1,
              ),
            ),
            child: Text(
              name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
                color: isHovered
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.95),
                shadows: const [
                  Shadow(
                    blurRadius: 8,
                    color: Colors.black87,
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

class _BenchSpotWeb extends StatelessWidget {
  const _BenchSpotWeb({required this.name, required this.isHovered});
  final String? name;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final selected = name != null;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHovered
            ? kNeonMint.withValues(alpha: 0.15)
            : Colors.black.withValues(alpha: selected ? 0.35 : 0.20),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isHovered ? kNeonMint : Colors.white.withValues(alpha: 0.15),
          width: isHovered ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ShirtIcon(selected: selected, size: 52),
          const SizedBox(height: 8),
          Text(
            name ?? 'Reserva',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              color: Colors.white.withValues(alpha: selected ? 1.0 : 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================== SHIRT SPOTS MOBILE ===========================
class _FieldSpotMobile extends StatelessWidget {
  const _FieldSpotMobile({required this.name});
  final String? name;

  @override
  Widget build(BuildContext context) {
    final selected = name != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                color: Colors.white,
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

class _BenchSpotMobile extends StatelessWidget {
  const _BenchSpotMobile({required this.name});
  final String? name;

  @override
  Widget build(BuildContext context) {
    final selected = name != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
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

/// =========================== SHIRT ICON ===========================
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

/// =========================== PAINTERS ===========================
class _StripesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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

    // Glow centro
    final centerFill = Paint()
      ..shader = RadialGradient(
        colors: [Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: 32));
    canvas.drawCircle(center, 32, centerFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
