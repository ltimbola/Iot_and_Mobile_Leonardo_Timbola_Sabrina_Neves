import 'package:flutter/material.dart';

/// Barra de progresso + labels de tempo.
class SongProgressBar extends StatelessWidget {
  final double progress;
  final String currentLabel;
  final String totalLabel;

  const SongProgressBar({
    super.key,
    required this.progress,
    required this.currentLabel,
    required this.totalLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(currentLabel, style: theme.textTheme.bodySmall),
            Text(totalLabel, style: theme.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}