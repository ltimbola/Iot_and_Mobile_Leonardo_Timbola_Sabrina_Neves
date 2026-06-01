import 'package:flutter/material.dart';
import 'controllers/connection_controller.dart';
import 'widgets/status_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartGuitar'),
        leading: const Icon(Icons.wifi),
      ),
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
                  isConnecting: _controller.isConnecting,
                ),
                const SizedBox(height: 20),
                if (_controller.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _controller.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                FilledButton.icon(
                  onPressed: _controller.isConnecting
                      ? null
                      : _controller.isConnected
                          ? _controller.disconnect
                          : _controller.connect,
                  icon: _controller.isConnecting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          _controller.isConnected ? Icons.wifi_off : Icons.wifi,
                        ),
                  label: Text(_controller.buttonLabel),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const GoToSongsButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
