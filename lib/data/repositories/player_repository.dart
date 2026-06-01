import '../../models/chord_event.dart';
import '../../models/song_model.dart';

abstract class PlayerRepository {
  ChordEvent getCurrentEvent(SongModel song, int eventIndex);
  int resolveEventIndex(
      SongModel song, Duration position, int currentEventIndex);
  String getNextChord(SongModel song, int eventIndex);
  Duration getTimeToNext(SongModel song, Duration position, int eventIndex);
}
