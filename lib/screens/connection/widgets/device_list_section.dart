import 'package:flutter/material.dart';
import '../controllers/connection_controller.dart';
import 'device_list_tile.dart';

class DeviceListSection extends StatelessWidget {
  final ConnectionController controller;
  final ThemeData theme;
  final ValueChanged<String> onConnected;

  const DeviceListSection({
    super.key,
    required this.controller,
    required this.theme,
    required this.onConnected,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.devices.isEmpty) {
      return Center(
        child: Text(
          'Nenhum dispositivo encontrado.\nToque em "Buscar dispositivos".',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: controller.devices.length,
      itemBuilder: (_, i) => DeviceListTile(
        device: controller.devices[i],
        isSelected: controller.selectedDevice?.address == controller.devices[i].address,
        onConnect: () async {
          final device = await controller.connectToDevice(controller.devices[i]);
          onConnected(device.name);
        },
      ),
    );
  }
}
