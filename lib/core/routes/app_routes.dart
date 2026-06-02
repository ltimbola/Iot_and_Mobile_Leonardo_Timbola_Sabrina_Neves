
import 'package:flutter/material.dart';
import '../../models/musica.dart';
import '../../models/song_model.dart';
import '../../screens/connection/connection_screen.dart';
import '../../screens/songs/songs_screen.dart';
import '../../screens/player/player_screen.dart';
import '../../screens/musicas/musicas_screen.dart';
import '../../screens/musica_player/musica_player_screen.dart';

abstract class AppRoutes {
  static const connection = '/';
  static const songs = '/songs';
  static const player = '/player';
  static const musicas = '/musicas';
  static const musicaPlayer = '/musica_player';

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

      case musicas:
        return MaterialPageRoute(builder: (_) => const MusicasScreen());

      case musicaPlayer:
        final musica = settings.arguments as Musica;
        return MaterialPageRoute(
          builder: (_) => MusicaPlayerScreen(musica: musica),
        );

      default:
        return MaterialPageRoute(builder: (_) => const ConnectionScreen());
    }
  }
}
