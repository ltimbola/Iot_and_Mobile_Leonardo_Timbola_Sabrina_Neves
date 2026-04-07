import 'package:flutter/material.dart';

/// Linha de controles do player: reset | play/pause | (futuro: avançar).
class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPlay,
    required this.onPause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── Reset ──
        IconButton.filledTonal(
          onPressed: onReset,
          iconSize: 28,
          icon: const Icon(Icons.replay),
          tooltip: 'Reiniciar',
        ),

        const SizedBox(width: 24),

        // ── Play / Pause ──
        IconButton.filled(
          onPressed: isPlaying ? onPause : onPlay,
          iconSize: 48,
          style: IconButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            padding: const EdgeInsets.all(16),
          ),
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          tooltip: isPlaying ? 'Pausar' : 'Tocar',
        ),

        const SizedBox(width: 24),

        // ── Stop ──
        IconButton.filledTonal(
          onPressed: onReset,
          iconSize: 28,
          icon: const Icon(Icons.stop),
          tooltip: 'Parar',
        ),
      ],
    );
  }
}