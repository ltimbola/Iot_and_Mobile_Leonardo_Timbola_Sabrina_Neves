import 'package:flutter/material.dart';
import '../../../models/song_model.dart';
import '../controllers/player_controller.dart';
import 'chord_card.dart';
import 'next_chord_widget.dart';
import 'player_controls.dart';
import 'progress_bar.dart';
import 'sync_status_card.dart';

class PlayerContent extends StatelessWidget {
  final SongModel song;
  final PlayerController controller;

  const PlayerContent({
    super.key,
    required this.song,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text(
          song.title,
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
        const SizedBox(height: 24),
        ChordCard(chord: controller.currentEvent.chord),
        const SizedBox(height: 16),
        NextChordWidget(nextChord: controller.nextChord),
        const SizedBox(height: 24),
        SongProgressBar(
          progress: controller.progress,
          currentLabel: controller.formatDuration(controller.currentPosition),
          totalLabel: controller.formatDuration(song.duration),
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
          lastChord: controller.lastSentChord,
          timeToNext: controller.timeToNext,
          isActive: controller.isPlaying,
        ),
      ],
    );
  }
}
