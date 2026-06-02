import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../models/musica.dart';
import '../../services/mqtt_service.dart';

class MusicasScreen extends StatelessWidget {
  const MusicasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqtt = MqttService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Músicas'),
        leading: const BackButton(),
        actions: [
          ListenableBuilder(
            listenable: mqtt,
            builder: (_, __) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.wifi,
                color: mqtt.isConnected ? Colors.green : Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListenableBuilder(
            listenable: mqtt,
            builder: (_, __) => mqtt.isConnected
                ? const SizedBox.shrink()
                : MaterialBanner(
                    content: const Text(
                      'MQTT desconectado. Volte à tela inicial para conectar.',
                    ),
                    leading:
                        const Icon(Icons.wifi_off, color: Colors.redAccent),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Conectar'),
                      ),
                    ],
                  ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: musicas.length,
              itemBuilder: (context, i) => _MusicaCard(
                musica: musicas[i],
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.musicaPlayer,
                  arguments: musicas[i],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MusicaCard extends StatelessWidget {
  final Musica musica;
  final VoidCallback onTap;

  const _MusicaCard({required this.musica, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.music_note,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          musica.nome,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${musica.notas.length} notas',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
