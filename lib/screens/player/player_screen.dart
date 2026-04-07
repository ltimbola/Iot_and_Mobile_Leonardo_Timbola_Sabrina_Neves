import 'package:flutter/material.dart';
import '../../models/song_model.dart';
import 'controllers/player_controller.dart';
import 'widgets/player_content.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel song;

  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final PlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PlayerController(widget.song);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.music_note),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => SafeArea(
          child: PlayerContent(song: widget.song, controller: _controller),
        ),
      ),
    );
  }
}