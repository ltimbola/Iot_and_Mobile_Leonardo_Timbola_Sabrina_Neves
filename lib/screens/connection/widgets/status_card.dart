import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final bool isConnected;
  final bool isConnecting;
  final String? deviceName;

  const StatusCard({
    super.key,
    required this.isConnected,
    this.isConnecting = false,
    this.deviceName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = isConnected
        ? Colors.green
        : isConnecting
            ? Colors.orange
            : Colors.redAccent;
    final statusText = isConnected
        ? 'Conectado'
        : isConnecting
            ? 'Conectando...'
            : 'Desconectado';

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi, size: 48, color: statusColor),
            const SizedBox(height: 12),
            Text(
              'Status MQTT',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              statusText,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (deviceName != null) ...[
              const SizedBox(height: 8),
              Text(deviceName!, style: theme.textTheme.bodyLarge),
            ],
          ],
        ),
      ),
    );
  }
}
