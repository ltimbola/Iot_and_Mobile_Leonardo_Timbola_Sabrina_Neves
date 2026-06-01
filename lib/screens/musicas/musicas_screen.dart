import 'package:flutter/material.dart';
import '../../models/musica.dart';
import '../../services/mqtt_service.dart';

class MusicasScreen extends StatefulWidget {
  const MusicasScreen({super.key});

  @override
  State<MusicasScreen> createState() => _MusicasScreenState();
}

class _MusicasScreenState extends State<MusicasScreen> {
  int _tocandoIndex = -1;
  int _notaAtualIndex = -1;
  int _geracao = 0;

  bool get _tocando => _tocandoIndex >= 0;

  Future<void> _tocar(int musicaIndex) async {
    _geracao++;
    final g = _geracao;
    final musica = musicas[musicaIndex];

    setState(() {
      _tocandoIndex = musicaIndex;
      _notaAtualIndex = 0;
    });

    for (int i = 0; i < musica.notas.length; i++) {
      if (_geracao != g) return;
      setState(() => _notaAtualIndex = i);
      MqttService.instance.publicarNota(musica.notas[i]['nota'] as String);
      await Future.delayed(
          Duration(milliseconds: musica.notas[i]['duracao'] as int));
    }

    if (_geracao == g) {
      setState(() {
        _tocandoIndex = -1;
        _notaAtualIndex = -1;
      });
    }
  }

  void _parar() {
    _geracao++;
    setState(() {
      _tocandoIndex = -1;
      _notaAtualIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mqtt = MqttService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Músicas'),
        leading: const BackButton(),
        actions: [
          ListenableBuilder(
            listenable: mqtt,
            builder: (_, __) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.wifi,
                color: mqtt.isConnected ? Colors.green : Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListenableBuilder(
            listenable: mqtt,
            builder: (_, __) => mqtt.isConnected
                ? const SizedBox.shrink()
                : MaterialBanner(
                    content: const Text(
                      'MQTT desconectado. Volte à tela inicial para conectar.',
                    ),
                    leading:
                        const Icon(Icons.wifi_off, color: Colors.redAccent),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Conectar'),
                      ),
                    ],
                  ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: _tocando
                ? _NotaAtualBanner(
                    musica: musicas[_tocandoIndex],
                    notaIndex: _notaAtualIndex,
                    onParar: _parar,
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: musicas.length,
              itemBuilder: (context, i) => _MusicaCard(
                musica: musicas[i],
                tocando: _tocandoIndex == i,
                notaAtualIndex: _tocandoIndex == i ? _notaAtualIndex : -1,
                onTocar: () {
                  if (_tocandoIndex == i) {
                    _parar();
                  } else {
                    _tocar(i);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotaAtualBanner extends StatelessWidget {
  final Musica musica;
  final int notaIndex;
  final VoidCallback onParar;

  const _NotaAtualBanner({
    required this.musica,
    required this.notaIndex,
    required this.onParar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nota = notaIndex >= 0 && notaIndex < musica.notas.length
        ? musica.notas[notaIndex]['nota'] as String
        : '—';

    return Container(
      width: double.infinity,
      color: theme.colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  musica.nome,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  nota,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'nota ${notaIndex + 1} / ${musica.notas.length}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),
          FilledButton.icon(
            onPressed: onParar,
            icon: const Icon(Icons.stop),
            label: const Text('Parar'),
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
          ),
        ],
      ),
    );
  }
}

class _MusicaCard extends StatelessWidget {
  final Musica musica;
  final bool tocando;
  final int notaAtualIndex;
  final VoidCallback onTocar;

  const _MusicaCard({
    required this.musica,
    required this.tocando,
    required this.notaAtualIndex,
    required this.onTocar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notaAtual = tocando && notaAtualIndex >= 0
        ? musica.notas[notaAtualIndex]['nota'] as String
        : null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: tocando ? theme.colorScheme.primaryContainer.withAlpha(80) : null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        child: Row(
          children: [
            Icon(
              tocando ? Icons.music_note : Icons.music_note_outlined,
              color: tocando ? theme.colorScheme.primary : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    musica.nome,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: tocando ? FontWeight.bold : null,
                      color: tocando ? theme.colorScheme.primary : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (notaAtual != null)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            notaAtual,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${notaAtualIndex + 1} / ${musica.notas.length}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      '${musica.notas.length} notas',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            tocando
                ? FilledButton.icon(
                    onPressed: onTocar,
                    icon: const Icon(Icons.stop, size: 18),
                    label: const Text('Parar'),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: theme.colorScheme.onError,
                      minimumSize: const Size(80, 36),
                    ),
                  )
                : FilledButton.icon(
                    onPressed: onTocar,
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Tocar'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(80, 36),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
