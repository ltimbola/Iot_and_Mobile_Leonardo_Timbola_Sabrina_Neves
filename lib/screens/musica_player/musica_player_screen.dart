import 'package:flutter/material.dart';
import '../../models/musica.dart';
import '../player/widgets/player_controls.dart';
import '../player/widgets/progress_bar.dart';
import '../player/widgets/sync_status_card.dart';
import 'musica_player_controller.dart';

class MusicaPlayerScreen extends StatefulWidget {
  final Musica musica;

  const MusicaPlayerScreen({super.key, required this.musica});

  @override
  State<MusicaPlayerScreen> createState() => _MusicaPlayerScreenState();
}

class _MusicaPlayerScreenState extends State<MusicaPlayerScreen> {
  late final MusicaPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MusicaPlayerController(widget.musica);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.musica.nome),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.music_note),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => SafeArea(
          child: _MusicaPlayerContent(
            musica: widget.musica,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}

class _MusicaPlayerContent extends StatelessWidget {
  final Musica musica;
  final MusicaPlayerController controller;

  const _MusicaPlayerContent({
    required this.musica,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text(
          musica.nome,
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          controller.statusLabel,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'nota ${controller.currentIndex + 1} / ${musica.notas.length}',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _NoteCard(nota: controller.currentNota),
        const SizedBox(height: 16),
        _NextNoteWidget(nextNota: controller.nextNota),
        const SizedBox(height: 24),
        SongProgressBar(
          progress: controller.progress,
          currentLabel: controller.formatDuration(controller.currentPosition),
          totalLabel: controller.formatDuration(controller.totalDuration),
        ),
        const SizedBox(height: 20),
        PlayerControls(
          isPlaying: controller.isPlaying,
          onPlay: controller.play,
          onPause: controller.pause,
          onReset: controller.reset,
        ),
        const SizedBox(height: 20),
        SyncStatusCard(
          lastChord: controller.lastSentNota.isEmpty
              ? '—'
              : controller.lastSentNota,
          timeToNext: controller.timeToNext,
          isActive: controller.isPlaying,
        ),
      ],
    );
  }
}

class _NoteCard extends StatelessWidget {
  final String nota;

  const _NoteCard({required this.nota});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nota atual',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withAlpha(180),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              nota,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Enviando via MQTT',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withAlpha(140),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextNoteWidget extends StatelessWidget {
  final String nextNota;

  const _NextNoteWidget({required this.nextNota});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Próxima nota:  ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            nextNota,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
