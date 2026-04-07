import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../models/song_model.dart';
import 'device_status_card.dart';
import 'song_list_tile.dart';

class SongsContent extends StatelessWidget {
  final String connectedDeviceName;
  final List<SongModel> songs;

  const SongsContent({
    super.key,
    required this.connectedDeviceName,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Text(
            'Escolha uma música para iniciar o treino',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 12),
        DeviceStatusCard(deviceName: connectedDeviceName),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: songs.length,
            itemBuilder: (_, i) => SongListTile(
              song: songs[i],
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.player,
                arguments: songs[i],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
