import 'package:flutter/material.dart';
import 'controllers/songs_controller.dart';
import 'widgets/songs_content.dart';

class SongsScreen extends StatefulWidget {
  final String connectedDeviceName;

  const SongsScreen({super.key, required this.connectedDeviceName});

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  final SongsController _controller = SongsController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songs = _controller.songs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Músicas'),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.music_note),
          ),
        ],
      ),
      body: SafeArea(
        child: SongsContent(
          connectedDeviceName: widget.connectedDeviceName,
          songs: songs,
        ),
      ),
    );
  }
}