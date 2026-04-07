import 'package:flutter/material.dart';

/// Card que exibe o status atual de conexão Bluetooth.
class StatusCard extends StatelessWidget {
  final bool isConnected;
  final String? deviceName;

  const StatusCard({
    super.key,
    required this.isConnected,
    this.deviceName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = isConnected ? Colors.green : Colors.redAccent;
    final statusText = isConnected ? 'Conectado' : 'Desconectado';

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bluetooth, size: 48, color: statusColor),
            const SizedBox(height: 12),
            Text(
              'Status do dispositivo',
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
              Text(
                deviceName!,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}