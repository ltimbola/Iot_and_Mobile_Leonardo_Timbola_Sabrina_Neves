import 'package:flutter/material.dart';
import '../../models/song_model.dart';
import '../../screens/connection/connection_screen.dart';
import '../../screens/songs/songs_screen.dart';
import '../../screens/player/player_screen.dart';

/// Gerencia rotas nomeadas do app.
abstract class AppRoutes {
  static const connection = '/';
  static const songs = '/songs';
  static const player = '/player';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case connection:
        return MaterialPageRoute(builder: (_) => const ConnectionScreen());

      case songs:
        final deviceName = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => SongsScreen(connectedDeviceName: deviceName),
        );

      case player:
        final song = settings.arguments as SongModel;
        return MaterialPageRoute(
          builder: (_) => PlayerScreen(song: song),
        );

      default:
        return MaterialPageRoute(builder: (_) => const ConnectionScreen());
    }
  }
}