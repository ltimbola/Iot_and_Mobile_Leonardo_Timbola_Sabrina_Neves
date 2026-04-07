import 'package:flutter/material.dart';

/// Card grande e central que exibe o acorde atual.
class ChordCard extends StatelessWidget {
  final String chord;

  const ChordCard({super.key, required this.chord});

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
              'Acorde atual',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withAlpha(180),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              chord,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Toque agora',
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