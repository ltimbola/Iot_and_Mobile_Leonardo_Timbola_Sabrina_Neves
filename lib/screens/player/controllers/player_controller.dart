import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../data/repositories/mock_player_repository.dart';
import '../../../data/repositories/player_repository.dart';
import '../../../domain/use_cases/player/format_duration_use_case.dart';
import '../../../domain/use_cases/player/get_current_event_use_case.dart';
import '../../../domain/use_cases/player/get_next_chord_use_case.dart';
import '../../../domain/use_cases/player/get_time_to_next_use_case.dart';
import '../../../domain/use_cases/player/resolve_event_index_use_case.dart';
import '../../../models/chord_event.dart';
import '../../../models/song_model.dart';

class PlayerController extends ChangeNotifier {
  PlayerController(this.song, {PlayerRepository? repository})
      : _repository = repository ?? MockPlayerRepository();

  final SongModel song;
  final PlayerRepository _repository;
  late final GetCurrentEventUseCase _getCurrentEvent =
      GetCurrentEventUseCase(_repository);
  late final ResolveEventIndexUseCase _resolveEventIndex =
      ResolveEventIndexUseCase(_repository);
  late final GetNextChordUseCase _getNextChord = GetNextChordUseCase(_repository);
  late final GetTimeToNextUseCase _getTimeToNext =
      GetTimeToNextUseCase(_repository);
  final FormatDurationUseCase _formatDuration = const FormatDurationUseCase();
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  int currentEventIndex = 0;
  String lastSentChord = '';
  Timer? _timer;

  ChordEvent get currentEvent => _getCurrentEvent(song, currentEventIndex);
  String get nextChord => _getNextChord(song, currentEventIndex);
  Duration get timeToNext => _getTimeToNext(song, currentPosition, currentEventIndex);
  double get progress => song.duration.inMilliseconds == 0
      ? 0
      : currentPosition.inMilliseconds / song.duration.inMilliseconds;
  bool get isFinished => currentPosition >= song.duration;
  String get statusLabel {
    if (isPlaying) return 'Sincronização ativa';
    if (isFinished) return 'Finalizado';
    return 'Conectado ao ESP32';
  }
  String formatDuration(Duration d) => _formatDuration(d);

  void play() {
    if (isFinished) reset();
    isPlaying = true;
    notifyListeners();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) => _tick());
  }

  void pause() {
    _timer?.cancel();
    isPlaying = false;
    notifyListeners();
  }

  void reset() {
    _timer?.cancel();
    isPlaying = false;
    currentPosition = Duration.zero;
    currentEventIndex = 0;
    lastSentChord = '';
    notifyListeners();
  }

  void _tick() {
    if (!isPlaying) return;
    currentPosition += const Duration(milliseconds: 100);
    _updateChordIndex();
    if (currentPosition >= song.duration) {
      currentPosition = song.duration;
      isPlaying = false;
      _timer?.cancel();
    }
    notifyListeners();
  }

  void _updateChordIndex() {
    final nextIndex = _resolveEventIndex(song, currentPosition, currentEventIndex);
    if (currentEventIndex != nextIndex) {
      currentEventIndex = nextIndex;
      lastSentChord = currentEvent.chord;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
