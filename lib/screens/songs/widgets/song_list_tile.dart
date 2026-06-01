import 'package:flutter/material.dart';
import '../../../models/song_model.dart';

/// Tile clicável que exibe uma música na lista.
class SongListTile extends StatelessWidget {
  final SongModel song;
  final VoidCallback onTap;

  const SongListTile({
    super.key,
    required this.song,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              // ── Ícone ──
              CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.album,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),

              // ── Textos ──
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${song.durationFormatted} • ${song.chordChanges} mudanças de acorde',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Ação ──
              Icon(
                Icons.play_arrow,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
