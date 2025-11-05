import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../widgets/campo_web.dart';

class MonteLeagueScreen extends StatefulWidget {
  const MonteLeagueScreen({super.key});

  @override
  State<MonteLeagueScreen> createState() => _MonteLeagueScreenState();
}

class _MonteLeagueScreenState extends State<MonteLeagueScreen> {
  final Map<int, String> players = {};
  final Map<int, String> benchPlayers = {};
  bool tilt3D = true;

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
      backgroundColor: const Color(0xFF0B1E1A),
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
                          leading: const Icon(
                            Icons.person,
                            color: Colors.white,
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

  void _applyDrop(DragData data, bool toBench, int targetIndex) {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 800;
    final isWebLayout = kIsWeb && isLargeScreen;

    return Scaffold(
      backgroundColor: isWebLayout
          ? const Color(0xFF071614) // Fundo mais escuro para web
          : const Color.fromARGB(255, 3, 48, 84),
      appBar: isWebLayout
          ? null // Sem AppBar na versão web
          : AppBar(
              title: const Text('Monte sua Liga'),
              centerTitle: true,
              backgroundColor: const Color(0xFF0B1E1A),
            ),
      body: SafeArea(
        child: isWebLayout
            ? _buildWebLayout()
            : _buildMobileLayout(screenHeight),
      ),
    );
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        // Sidebar esquerda com info
        Container(
          width: 320,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF0B1E1A), const Color(0xFF071614)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(5, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header com logo/título
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Fantasy League',
                      style: TextStyle(
                        color: Color(0xFF00FFB1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Banner image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/imagem1.jpg',
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.white24,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Título
                const Text(
                  'Monte sua Equipa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Escolha seus jogadores e crie o time dos sonhos para competir em ligas emocionantes.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Info cards
                _buildInfoCard(
                  'Jogadores',
                  '${players.length}/15',
                  Icons.group,
                ),
                const SizedBox(height: 12),
                _buildInfoCard('Saldo', '€100M', Icons.account_balance_wallet),
                const SizedBox(height: 12),
                _buildInfoCard('Formação', '4-3-3', Icons.grid_3x3),

                const SizedBox(height: 24),

                // Toggle 3D
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.threed_rotation,
                            color: Color(0xFF00FFB1),
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Visualização 3D',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: tilt3D,
                        onChanged: (v) => setState(() => tilt3D = v),
                        activeThumbColor: const Color(0xFF00FFB1),
                        inactiveThumbColor: Colors.white38,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Botão continuar
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FFB1),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),

        // Campo principal
        Expanded(
          child: CampoAdaptativo(
            players: players,
            benchPlayers: benchPlayers,
            formation: formation,
            onPlayerSelect: _openPlayerSelect,
            onDrop: _applyDrop,
            tilt3D: tilt3D,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double screenHeight) {
    final fieldHeight = screenHeight * 0.7;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/imagem1.jpg',
                    fit: BoxFit.cover,
                    height: 120,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.white54,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Escolha sua equipa!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  'Compita contra amigos e outros fãs em uma temporada cheia de emoção e estratégia.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[600],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Jogadores ${players.length}/15',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'Saldo €100M',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: fieldHeight,
            child: CampoAdaptativo(
              players: players,
              benchPlayers: benchPlayers,
              formation: formation,
              onPlayerSelect: _openPlayerSelect,
              onDrop: _applyDrop,
              tilt3D: tilt3D,
            ),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 10.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[600],
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Jogadores ${players.length}/15',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Saldo €100M',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              margin: const EdgeInsets.fromLTRB(20.0, 10, 10.0, 20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 1, 35, 25),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Text(
                  'Continuar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF00FFB1).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF00FFB1), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
