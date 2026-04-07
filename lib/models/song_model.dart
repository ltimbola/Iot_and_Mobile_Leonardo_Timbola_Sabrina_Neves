import 'chord_event.dart';

/// Representa uma música com seus eventos de acorde.
class SongModel {
  final String title;
  final String audioPath;
  final Duration duration;
  final List<ChordEvent> events;

  const SongModel({
    required this.title,
    required this.audioPath,
    required this.duration,
    required this.events,
  });

  String get durationFormatted {
    final m = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  int get chordChanges => events.length > 1 ? events.length - 1 : 0;
}