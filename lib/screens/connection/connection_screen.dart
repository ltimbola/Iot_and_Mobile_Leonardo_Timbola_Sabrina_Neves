import 'package:flutter/material.dart';
import 'controllers/connection_controller.dart';
import 'widgets/status_card.dart';
import 'widgets/scan_devices_button.dart';
import 'widgets/device_list_section.dart';
import 'widgets/go_to_songs_button.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final ConnectionController _controller = ConnectionController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('SmartGuitar'), leading: const Icon(Icons.bluetooth)),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                StatusCard(
                  isConnected: _controller.isConnected,
                  deviceName: _controller.selectedDevice?.name,
                ),
                const SizedBox(height: 20),
                ScanDevicesButton(controller: _controller),
                const SizedBox(height: 24),
                if (_controller.devices.isNotEmpty)
                  Align(alignment: Alignment.centerLeft, child: Text('Dispositivos encontrados', style: theme.textTheme.titleMedium)),
                const SizedBox(height: 8),
                Expanded(
                  child: DeviceListSection(
                    controller: _controller,
                    theme: theme,
                    onConnected: (name) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Conectado a $name')));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24, top: 8),
                  child: GoToSongsButton(selectedOrFallbackName: _controller.selectedOrFallbackName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}