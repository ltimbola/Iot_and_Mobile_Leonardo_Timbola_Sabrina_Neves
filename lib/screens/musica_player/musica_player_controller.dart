import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../models/musica.dart';
import '../../services/mqtt_service.dart';

class MusicaPlayerController extends ChangeNotifier {
  MusicaPlayerController(this.musica) {
    int acc = 0;
    for (final nota in musica.notas) {
      _noteStartTimes.add(acc);
      acc += nota['duracao'] as int;
    }
    _totalMs = acc;
  }

  final Musica musica;
  bool isPlaying = false;
  int _elapsedMs = 0;
  int _totalMs = 0;
  int _currentIndex = 0;
  String _lastSentNota = '';
  Timer? _timer;
  final List<int> _noteStartTimes = [];

  int get currentIndex => _currentIndex;

  String get currentNota => musica.notas.isNotEmpty
      ? musica.notas[_currentIndex]['nota'] as String
      : '—';

  String get nextNota => _currentIndex + 1 < musica.notas.length
      ? musica.notas[_currentIndex + 1]['nota'] as String
      : '—';

  String get lastSentNota => _lastSentNota;

  bool get isFinished => _totalMs > 0 && _elapsedMs >= _totalMs;

  double get progress =>
      _totalMs == 0 ? 0.0 : (_elapsedMs / _totalMs).clamp(0.0, 1.0);

  Duration get currentPosition => Duration(milliseconds: _elapsedMs);
  Duration get totalDuration => Duration(milliseconds: _totalMs);

  Duration get timeToNext {
    if (_currentIndex + 1 >= _noteStartTimes.length) return Duration.zero;
    final diff = _noteStartTimes[_currentIndex + 1] - _elapsedMs;
    return Duration(milliseconds: diff.clamp(0, _totalMs));
  }

  bool get mqttConnected => MqttService.instance.isConnected;

  String get statusLabel {
    if (isPlaying) return 'Sincronização ativa';
    if (isFinished) return 'Finalizado';
    return mqttConnected ? 'Conectado via MQTT' : 'MQTT desconectado';
  }

  String formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void play() {
    if (isFinished) reset();
    isPlaying = true;
    _publishCurrentNota();
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
    _elapsedMs = 0;
    _currentIndex = 0;
    _lastSentNota = '';
    notifyListeners();
  }

  void _tick() {
    if (!isPlaying) return;
    _elapsedMs += 100;
    _updateNoteIndex();
    if (_elapsedMs >= _totalMs) {
      _elapsedMs = _totalMs;
      isPlaying = false;
      _timer?.cancel();
    }
    notifyListeners();
  }

  void _updateNoteIndex() {
    for (int i = _currentIndex + 1; i < _noteStartTimes.length; i++) {
      if (_elapsedMs >= _noteStartTimes[i]) {
        _currentIndex = i;
        _publishCurrentNota();
      } else {
        break;
      }
    }
  }

  void _publishCurrentNota() {
    if (_currentIndex < musica.notas.length) {
      final nota = musica.notas[_currentIndex]['nota'] as String;
      _lastSentNota = nota;
      MqttService.instance.publicarNota(nota);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
