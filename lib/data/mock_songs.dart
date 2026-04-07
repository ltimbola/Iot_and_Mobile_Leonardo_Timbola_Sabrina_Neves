import '../models/song_model.dart';
import '../models/chord_event.dart';

/// Dados mock de músicas para o MVP.
final List<SongModel> mockSongs = [
  SongModel(
    title: 'Stand By Me',
    audioPath: 'assets/audio/stand_by_me.mp3',
    duration: const Duration(minutes: 3, seconds: 45),
    events: const [
      ChordEvent(timestamp: Duration.zero, chord: 'G'),
      ChordEvent(timestamp: Duration(seconds: 4), chord: 'Em'),
      ChordEvent(timestamp: Duration(seconds: 8), chord: 'C'),
      ChordEvent(timestamp: Duration(seconds: 12), chord: 'D'),
      ChordEvent(timestamp: Duration(seconds: 16), chord: 'G'),
      ChordEvent(timestamp: Duration(seconds: 20), chord: 'Em'),
      ChordEvent(timestamp: Duration(seconds: 24), chord: 'C'),
      ChordEvent(timestamp: Duration(seconds: 28), chord: 'D'),
      ChordEvent(timestamp: Duration(seconds: 32), chord: 'G'),
    ],
  ),
  SongModel(
    title: 'Wonderful Tonight',
    audioPath: 'assets/audio/wonderful_tonight.mp3',
    duration: const Duration(minutes: 4, seconds: 12),
    events: const [
      ChordEvent(timestamp: Duration.zero, chord: 'G'),
      ChordEvent(timestamp: Duration(seconds: 5), chord: 'D'),
      ChordEvent(timestamp: Duration(seconds: 10), chord: 'C'),
      ChordEvent(timestamp: Duration(seconds: 15), chord: 'D'),
      ChordEvent(timestamp: Duration(seconds: 20), chord: 'G'),
      ChordEvent(timestamp: Duration(seconds: 25), chord: 'D'),
      ChordEvent(timestamp: Duration(seconds: 30), chord: 'Em'),
      ChordEvent(timestamp: Duration(seconds: 35), chord: 'C'),
    ],
  ),
  SongModel(
    title: 'Knockin\' on Heaven\'s Door',
    audioPath: 'assets/audio/knockin_on_heavens_door.mp3',
    duration: const Duration(minutes: 2, seconds: 58),
    events: const [
      ChordEvent(timestamp: Duration.zero, chord: 'G'),
      ChordEvent(timestamp: Duration(seconds: 4), chord: 'D'),
      ChordEvent(timestamp: Duration(seconds: 8), chord: 'Am'),
      ChordEvent(timestamp: Duration(seconds: 12), chord: 'G'),
      ChordEvent(timestamp: Duration(seconds: 16), chord: 'D'),
      ChordEvent(timestamp: Duration(seconds: 20), chord: 'C'),
      ChordEvent(timestamp: Duration(seconds: 24), chord: 'G'),
    ],
  ),
];