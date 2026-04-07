import '../../models/chord_event.dart';
import '../../models/song_model.dart';
import 'player_repository.dart';

class MockPlayerRepository implements PlayerRepository {
  @override
  ChordEvent getCurrentEvent(SongModel song, int eventIndex) {
    if (song.events.isEmpty) {
      return const ChordEvent(timestamp: Duration.zero, chord: '—');
    }
    return song.events[eventIndex];
  }

  @override
  int resolveEventIndex(SongModel song, Duration position, int currentEventIndex) {
    for (int i = song.events.length - 1; i >= 0; i--) {
      if (position < song.events[i].timestamp) continue;
      return i;
    }
    return currentEventIndex;
  }

  @override
  String getNextChord(SongModel song, int eventIndex) {
    if (eventIndex + 1 >= song.events.length) return '—';
    return song.events[eventIndex + 1].chord;
  }

  @override
  Duration getTimeToNext(SongModel song, Duration position, int eventIndex) {
    if (eventIndex + 1 >= song.events.length) return Duration.zero;
    final next = song.events[eventIndex + 1].timestamp;
    final diff = next - position;
    return diff.isNegative ? Duration.zero : diff;
  }
}
