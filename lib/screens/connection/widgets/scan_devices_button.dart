import 'package:flutter/material.dart';
import '../controllers/connection_controller.dart';

class ScanDevicesButton extends StatelessWidget {
  final ConnectionController controller;

  const ScanDevicesButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: controller.isLoading ? null : controller.scanDevices,
      icon: controller.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Icon(Icons.search),
      label: Text(controller.isLoading ? 'Buscando...' : controller.scanButtonLabel),
    );
  }
}
