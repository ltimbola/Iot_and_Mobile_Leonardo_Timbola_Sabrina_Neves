import 'package:flutter/material.dart';
import 'status_item.dart';

class SyncStatusCard extends StatelessWidget {
  final String lastChord;
  final Duration timeToNext;
  final bool isActive;

  const SyncStatusCard({
    super.key,
    required this.lastChord,
    required this.timeToNext,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nextSecs =
        '${(timeToNext.inMilliseconds / 1000).toStringAsFixed(1)}s';

    return Card(
      color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 12,
          children: [
            StatusItem(
              icon: Icons.music_note,
              label: lastChord.isEmpty ? '—' : lastChord,
              caption: 'Último enviado',
            ),
            StatusItem(
              icon: Icons.timer,
              label: nextSecs,
              caption: 'Próx. envio',
            ),
            StatusItem(
              icon: Icons.wifi,
              label: isActive ? 'Ativo' : 'Idle',
              caption: 'MQTT',
              color: isActive ? Colors.green : null,
            ),
          ],
        ),
      ),
    );
  }
}
