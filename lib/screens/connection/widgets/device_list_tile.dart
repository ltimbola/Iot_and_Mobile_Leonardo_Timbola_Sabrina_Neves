import 'package:flutter/material.dart';
import '../../../models/device_model.dart';

/// Tile individual de um dispositivo Bluetooth encontrado.
class DeviceListTile extends StatelessWidget {
  final DeviceModel device;
  final bool isSelected;
  final VoidCallback onConnect;

  const DeviceListTile({
    super.key,
    required this.device,
    required this.isSelected,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: isSelected
          ? theme.colorScheme.primaryContainer
          : theme.cardTheme.color,
      child: ListTile(
        leading: Icon(
          Icons.bluetooth,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(device.name),
        subtitle: Text(
          device.address,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: isSelected
            ? Chip(
                label: const Text('Conectado'),
                backgroundColor: Colors.green.withAlpha(40),
                side: BorderSide.none,
              )
            : FilledButton.tonal(
                onPressed: onConnect,
                child: const Text('Conectar'),
              ),
      ),
    );
  }
}
